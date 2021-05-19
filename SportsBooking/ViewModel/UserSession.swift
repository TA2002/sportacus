//
//  UserSession.swift
//  SportsBooking
//
//  Created by Tarlan Askaruly on 12.05.2021.
//

import Foundation
import SwiftUI
import Firebase
import Combine
import SwiftDate

class UserSession: ObservableObject {
    @Published var userLogedIn: Bool = false
    @Published private var model: SportsBooking
    
    private let database = Database.database(url: "https://sportacus-dd671-default-rtdb.asia-southeast1.firebasedatabase.app").reference()
    
    private var cancellable: AnyCancellable?
    private var usersObserve: AnyCancellable?
    
    private var bookingObserver: AnyCancellable?
    
    var footballFacilities: [FootballFacility] {
        self.model.footballFacilities
    }
    
    var profile: Profile {
        self.model.profile
    }
    
    var datesForBooking: [DateInRegion]? {
        self.model.datesForBooking
    }
    
    var availableTimeSessionsForBooking: [String: [TimeSession]] {
        self.model.availableTimeSessionsForBooking
    }
    
    var closedTimesSessions: [TimeSession]? {
        self.model.closedTimesSessions
    }
    
    func createNewBookingSession(footballFacility: FootballFacility, footballPitch: FootballPitch) {
        self.model.createNewBookingSession(footballFacility: footballFacility, footballPitch: footballPitch)
    }
    
    func sessionsFor(date: DateInRegion) -> [TimeSession] {
        self.model.availableTimeSessionsForBooking["\(date.day).\(date.month).\(date.year)"]!
    }
    
    func downloadClosedSessions(footballFacilityId: Int, footballPitchId: Int, date: DateInRegion) {
        let dateString = "\(date.day)-\(date.month)-\(date.year)"
        let bookingsRef = Database.database(url: "https://sportacus-dd671-default-rtdb.asia-southeast1.firebasedatabase.app").reference().child(dateString).child("\(footballFacilityId)").child("\(footballPitchId)")
        
        bookingsRef.removeAllObservers()
        model.closedTimesSessions = nil
        
        bookingsRef.observe(.value, with: { (snapshot) in
            var value = snapshot.value as? [[String: Int]] ?? [[String: Int]]()
            self.model.closedTimesSessions = []
            for session in value {
                self.model.closedTimesSessions?.append(TimeSession(from: session))
            }
        }) { (error) in
            print(error.localizedDescription)
        }
        
    }
    
    func bookSession(footballFacilityId: Int, footballPitchId: Int, date: DateInRegion, sessionsForBooking: [TimeSession]) {
        let dateString = "\(date.day)-\(date.month)-\(date.year)"
        let bookingsRef = Database.database(url: "https://sportacus-dd671-default-rtdb.asia-southeast1.firebasedatabase.app").reference().child(dateString).child("\(footballFacilityId)").child("\(footballPitchId)")
        
        var propertyLists: [[String: Any]] = [[String: Any]]()
        
        for index in (0..<sessionsForBooking.count) {
            propertyLists.append(sessionsForBooking[index].asPropertyList())
        }
        
        bookingsRef.observeSingleEvent(of: .value, with: { (snapshot) in
            var value = snapshot.value as? [[String: Any]] ?? [[String: Any]]()
            value.append(contentsOf: propertyLists)
            bookingsRef.setValue(value)
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    init() {
        let facilities = [FootballFacility]()
        let profile = Profile(email: "", firstName: "", lastName: "", phoneNumber: "", favoriteIds: [])
        
        self.model = SportsBooking(footballFacilities: facilities, profile: profile)
        userLogedIn = isUserLoggedIn()
        
        print("isLogedIn: \(userLogedIn)")
        
        let profileRef = Database.database(url: "https://sportacus-dd671-default-rtdb.asia-southeast1.firebasedatabase.app").reference().ref.child("users")
        
        let sportsFacilitiesRef = Database.database(url: "https://sportacus-dd671-default-rtdb.asia-southeast1.firebasedatabase.app").reference().ref.child("sportsFacilities")
        
        cancellable = $userLogedIn.sink { isLogedIn in
            if isLogedIn {
                print("jhey")
                

                var currentTimeStamp: TimeInterval?

                let ref = Database.database(url: "https://sportacus-dd671-default-rtdb.asia-southeast1.firebasedatabase.app").reference().child("serverTimestamp")

                ref.setValue(ServerValue.timestamp())

                ref.observeSingleEvent(of: .value, with: { snap in
                    if let t = snap.value as? TimeInterval {
                        
                        currentTimeStamp = t/1000
                        let timeString = "\(Date(timeIntervalSince1970: currentTimeStamp ?? TimeInterval(0)))"
                        var date = ""
                        var cnt = 0
                        for char in timeString {
                            if char == " " {
                                cnt += 1
                                if cnt == 2 {
                                    break
                                }
                                else {
                                    date.append(" ")
                                }
                            }
                            else {
                                date.append(char)
                            }
                        }
                        self.model.changeDate(date: date)
                    }
                })
                
                profileRef.child("\(String(describing: Auth.auth().currentUser!.uid))").observeSingleEvent(of: .value) { snapshot in
                    if let userDict = snapshot.value as? [String:Any] {
                        let firstName = userDict["firstName"] as? String ?? ""
                        let lastName = userDict["lastName"] as? String ?? ""
                        let email = userDict["email"] as? String ?? ""
                        let phoneNumber = userDict["phoneNumber"] as? String ?? ""
                        let favoriteIds = userDict["favoriteIds"] as? [Int] ?? []
                        self.model.createProfile(profile: Profile(email: email, firstName: firstName, lastName: lastName, phoneNumber: phoneNumber, favoriteIds: favoriteIds))
                    }
                    profileRef.removeAllObservers()
                    //print(self.model.profile)
                }

                sportsFacilitiesRef.observeSingleEvent(of: .value) { snapshot in
                    for child in snapshot.children {
                        let childSnapshot = snapshot.childSnapshot(forPath: (child as AnyObject).key)
                        if let facilityDict = childSnapshot.value as? [String:Any] {

                            let id = facilityDict["id"] as? Int ?? 0
                            let name = facilityDict["name"] as? String ?? ""
                            let address = facilityDict["address"] as? String ?? ""

                            var reviews = [Review]()
                            for review in childSnapshot.childSnapshot(forPath: "reviews").children {
                                let reviewSnapshot = childSnapshot.childSnapshot(forPath: "reviews").childSnapshot(forPath: (review as AnyObject).key)
                                if let reviewDict = reviewSnapshot.value as? [String: Any] {
                                    let reviewContent = reviewDict["reviewContent"] as? String ?? ""
                                    let reviewRating = reviewDict["reviewRating"] as? Int ?? 1
                                    reviews.append(Review(reviewContent: reviewContent, reviewRating: reviewRating))
                                }
                            }

                            var photoUrls = [String]()

                            for photoUrl in childSnapshot.childSnapshot(forPath: "photoUrls").children {
                                let photoSnapshot = childSnapshot.childSnapshot(forPath: "photoUrls").childSnapshot(forPath: (photoUrl as AnyObject).key)
                                photoUrls.append(photoSnapshot.value as? String ?? "") //URL(string: )!
                            }

                            var schedule: Schedule

                            let days = ["workdays", "saturday", "sunday"]
                            var timeSessions: [TimeSession] = []
                            for day in days {
                                let startHours = childSnapshot.childSnapshot(forPath: "schedule").childSnapshot(forPath: day).childSnapshot(forPath: "startHours").value as? Int ?? 0
                                let startMinutes = childSnapshot.childSnapshot(forPath: "schedule").childSnapshot(forPath: day).childSnapshot(forPath: "startMinutes").value as? Int ?? 0
                                let finishHours = childSnapshot.childSnapshot(forPath: "schedule").childSnapshot(forPath: day).childSnapshot(forPath: "finishHours").value  as? Int ?? 0
                                let finishMinutes = childSnapshot.childSnapshot(forPath: "schedule").childSnapshot(forPath: day).childSnapshot(forPath: "finishMinutes").value as? Int ?? 0
                                timeSessions.append(TimeSession(startHours: startHours, startMinutes: startMinutes, finishHours: finishHours, finishMinutes: finishMinutes))
                            }

                            schedule = Schedule(workdays: timeSessions[0], saturday: timeSessions[1], sunday: timeSessions[2])

                            var footballPitches = [FootballPitch]()

                            for pitch in childSnapshot.childSnapshot(forPath: "footballPitches").children {
                                let pitchSnapshot = childSnapshot.childSnapshot(forPath: "footballPitches").childSnapshot(forPath: (pitch as AnyObject).key)
                                let conveniences = pitchSnapshot.childSnapshot(forPath: "conveniences").value as? [String] ?? []
                                let floorMaterial = pitchSnapshot.childSnapshot(forPath: "floorMaterial").value as? String ?? ""
                                let id = pitchSnapshot.childSnapshot(forPath: "id").value as? Int ?? 0
                                let lengthInMeters = pitchSnapshot.childSnapshot(forPath: "lengthInMeters").value as? Int ?? 0
                                let widthInMeters = pitchSnapshot.childSnapshot(forPath: "widthInMeters").value as? Int ?? 0
                                let pricePerHour = pitchSnapshot.childSnapshot(forPath: "pricePerHour").value as? Int ?? 0
                                let type = pitchSnapshot.childSnapshot(forPath: "type").value as? String ?? ""
                                footballPitches.append(FootballPitch(id: id, type: type, floorMaterial: floorMaterial, lengthInMeters: lengthInMeters, widthInMeters: widthInMeters, conveniences: conveniences, pricePerHour: pricePerHour))
                            }
                            self.model.addFootballFacility(footballFacility: FootballFacility(id: id, name: name, address: address, reviews: reviews, photoUrls: photoUrls, schedule: schedule, footballPitches: footballPitches))
                            //print(self.model.footballFacilities)
                        }

                    }
                    sportsFacilitiesRef.removeAllObservers()
                }
                
            }
            else {
                profileRef.removeAllObservers()
                sportsFacilitiesRef.removeAllObservers()
                let facilities = [FootballFacility]()
                let profile = Profile(email: "", firstName: "", lastName: "", phoneNumber: "", favoriteIds: [])
                
                self.model = SportsBooking(footballFacilities: facilities, profile: profile)
            }
        }
        
    }
    
    
    func addFootballFacility(footballFacility: FootballFacility) {
        model.addFootballFacility(footballFacility: footballFacility)
    }
    
    func changeFootballFacilityInformation(for footballFacility: FootballFacility) {
        model.changeFootballFacilityInformation(for: footballFacility)
    }
    
    func userDidLogIn() {
        userLogedIn = true
        //UserDefaults.standard.set(true, forKey: "userLogedIn")
        //print(Auth.auth().currentUser?.email ?? "")
    }
    
    func userDidLogOut() {
        do {
            try Auth.auth().signOut()
            userLogedIn = false
            //print("userLogenIn: \(userLogedIn)")
        } catch {
          //print("Sign out error")
        }
    }
    
    func isUserLoggedIn() -> Bool {
      return Auth.auth().currentUser != nil
    }
    
}
