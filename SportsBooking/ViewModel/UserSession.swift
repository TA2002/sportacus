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

class UserSession: ObservableObject {
    @Published var userLogedIn: Bool = false
    @Published private var model: SportsBooking
    
    private let database = Database.database(url: "https://sportacus-dd671-default-rtdb.asia-southeast1.firebasedatabase.app").reference()
    
    private var cancellable: AnyCancellable?
    private var usersObserve: AnyCancellable?
    
    init() {
        var facilities = [FootballFacility]()
        var profile = Profile(email: "", firstName: "", lastName: "", phoneNumber: "", favoriteIds: [])
        
        self.model = SportsBooking(footballFacilities: facilities, profile: profile)
        userLogedIn = isUserLoggedIn()
        
        print("isLogedIn: \(userLogedIn)")
        
        let profileRef = Database.database(url: "https://sportacus-dd671-default-rtdb.asia-southeast1.firebasedatabase.app").reference().ref.child("users")
        
        let sportsFacilitiesRef = Database.database(url: "https://sportacus-dd671-default-rtdb.asia-southeast1.firebasedatabase.app").reference().ref.child("sportsFacilities")
        
        cancellable = $userLogedIn.sink { isLogedIn in
            if isLogedIn {
                print("jhey")

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
                    print(self.model.profile)
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

                            var photoUrls = [URL]()

                            for photoUrl in childSnapshot.childSnapshot(forPath: "photoUrls").children {
                                let photoSnapshot = childSnapshot.childSnapshot(forPath: "photoUrls").childSnapshot(forPath: (photoUrl as AnyObject).key)
                                photoUrls.append(URL(string: photoSnapshot.value as? String ?? "")!)
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
                            print(self.model.footballFacilities)
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
//
//    private func createSportsBooking() -> SportsBooking {
//        private let database = Database.database(url: "https://sportacus-dd671-default-rtdb.asia-southeast1.firebasedatabase.app").reference()
//
//
//        let firstName = database.child("users").child("\(String(describing: Auth.auth().currentUser!.uid))").child("firstName")
//
//        let sportsFacilities = FootballFacility(id: <#T##Int#>, name: <#T##String#>, address: <#T##String#>, reviews: <#T##[Review]#>, photoUrls: <#T##[URL]#>, schedule: <#T##TimeSession#>, footballPitches: <#T##[FootballPitch]#>)
//
//        let profile = Profile(email: firstName, firstName: firstName, lastName: firstName, phoneNumber: firstName)
//
//        return SportsBooking(footballFacilities: sportsFacilities, profile: profile)
////        database.child("users").child("\(String(describing: Auth.auth().currentUser!.uid))").child("lastName").setValue(lastName)
////        database.child("users").child("\(String(describing: Auth.auth().currentUser!.uid))").child("email").setValue(email)
////        database.child("users").child("\(String(describing: Auth.auth().currentUser!.uid))").child("phoneNumber").setValue(contactNo)
////        var profile: Profile = Profile(email: "", firstName: "", lastName: "", phoneNumber: "")
//    }
//
    func addFootballFacility(footballFacility: FootballFacility) {
        model.addFootballFacility(footballFacility: footballFacility)
    }
    
    func changeFootballFacilityInformation(for footballFacility: FootballFacility) {
        model.changeFootballFacilityInformation(for: footballFacility)
    }
    
    func userDidLogIn() {
        userLogedIn = true
        //UserDefaults.standard.set(true, forKey: "userLogedIn")
        print(Auth.auth().currentUser?.email ?? "")
    }
    
    func userDidLogOut() {
        do {
            try Auth.auth().signOut()
            userLogedIn = false
            print("userLogenIn: \(userLogedIn)")
        } catch {
          print("Sign out error")
        }
    }
    
    func isUserLoggedIn() -> Bool {
      return Auth.auth().currentUser != nil
    }
    
}
