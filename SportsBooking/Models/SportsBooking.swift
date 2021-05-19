//
//  SportsBooking.swift
//  SportsBooking
//
//  Created by Tarlan Askaruly on 15.05.2021.
//

import Foundation
import SwiftDate

extension DateInRegion {
    var withoutTime: String {
        return String(self.toString().prefix(upTo: self.toString().firstIndex(of: " ")!))
    }
    var dayAndMonth: String {
        var month = ""
        var day = ""
        var cnt = 0
        for char in self.toString() {
            if char == " " {
                cnt += 1
            }
            if cnt == 3 {
                break
            }
            else if cnt >= 2 && char != " " {
                day.append(char)
            }
            else if cnt >= 1 && char != " " {
                month.append(char)
            }
        }
        return "\(day) \(month)"
    }
}

struct SportsBooking {
    private(set) var footballFacilities: [FootballFacility]
    private(set) var profile: Profile
    private(set) var datesForBooking: [DateInRegion]?
    
    var closedTimesSessions: [TimeSession]?
    
    private(set) var availableTimeSessionsForBooking: [String: [TimeSession]]
    
    init(footballFacilities: [FootballFacility], profile: Profile) {
        self.footballFacilities = footballFacilities
        self.profile = profile
        datesForBooking = nil
        availableTimeSessionsForBooking = [String: [TimeSession]]()
        //datesForBooking.append()
    }
    
    mutating func createNewBookingSession(footballFacility: FootballFacility, footballPitch: FootballPitch) {
        
        if datesForBooking == nil {
            return
        }
        for index in 0..<datesForBooking!.count {
            var workTime: TimeSession
            switch datesForBooking![index].withoutTime {
                case "Сб":
                    workTime = footballFacility.schedule.saturday
                case "Вс":
                    workTime = footballFacility.schedule.sunday
                default:
                    workTime = footballFacility.schedule.workdays
            }
            var currentSession = TimeSession(startHours: workTime.startHours, startMinutes: workTime.startMinutes, finishHours: workTime.startMinutes == 30 ? workTime.startHours + 1 : workTime.startHours, finishMinutes: workTime.startMinutes == 30 ? 0 : 30)
            availableTimeSessionsForBooking["\(datesForBooking![index].day).\(datesForBooking![index].month).\(datesForBooking![index].year)"] = []
            availableTimeSessionsForBooking["\(datesForBooking![index].day).\(datesForBooking![index].month).\(datesForBooking![index].year)"]?.append(currentSession)
            
            while(true) {
                currentSession = TimeSession(startHours: currentSession.finishHours, startMinutes: currentSession.finishMinutes, finishHours: currentSession.finishMinutes == 30 ? currentSession.finishHours + 1 : currentSession.finishHours, finishMinutes: currentSession.finishMinutes == 30 ? 0 : 30)
                availableTimeSessionsForBooking["\(datesForBooking![index].day).\(datesForBooking![index].month).\(datesForBooking![index].year)"]?.append(currentSession)
                if currentSession.finishHours == workTime.finishHours && currentSession.finishMinutes == workTime.finishMinutes {
                    break
                }
            }
            
        }
        print(footballFacility.schedule)
       // print(availableTimeSessionsForBooking["\(datesForBooking![0].day).\(datesForBooking![0].month).\(datesForBooking![0].year)"])
        
    }
    
    mutating func addFootballFacility(footballFacility: FootballFacility) {
        self.footballFacilities.append(footballFacility)
    }
    
    mutating func changeDate(date: String) {
        if date.contains("1970") {
            datesForBooking = nil
        }
        else {
            let rAzores = Region(calendar: Calendars.gregorian, zone: Zones.atlanticAzores, locale: Locales.russian)
            let rAlmaty = Region(calendar: Calendars.gregorian, zone: Zones.asiaAlmaty, locale: Locales.russian)
            //let dateAzores = DateInRegion(date, format: dateFormat, region: rAzores)!
            let dateInAzores = date.toDate(region: rAzores)
            var currentDateInAlmaty = dateInAzores?.convertTo(region: rAlmaty)
            datesForBooking = []
            datesForBooking?.append(currentDateInAlmaty!)
            
            for _ in (0..<6) {
                currentDateInAlmaty = currentDateInAlmaty?.dateAt(.tomorrow)
                datesForBooking?.append(currentDateInAlmaty!)
            }
        }
    }
    
    mutating func changeFootballFacilityInformation(for footballFacility: FootballFacility) {
        for index in (0..<footballFacilities.count) {
            if footballFacilities[index].id == footballFacility.id {
                footballFacilities[index] = footballFacility
                break
            }
        }
    }
    
    mutating func createProfile(profile: Profile) {
        self.profile = profile
    }
    
}
