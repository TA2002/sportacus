//
//  SportsBooking.swift
//  SportsBooking
//
//  Created by Tarlan Askaruly on 15.05.2021.
//

import Foundation

struct SportsBooking {
    private(set) var footballFacilities: [FootballFacility]
    private(set) var profile: Profile
    
    init(footballFacilities: [FootballFacility], profile: Profile) {
        self.footballFacilities = footballFacilities
        self.profile = profile
    }
    
    mutating func addFootballFacility(footballFacility: FootballFacility) {
        self.footballFacilities.append(footballFacility)
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
