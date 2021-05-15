//
//  Profile.swift
//  SportsBooking
//
//  Created by Tarlan Askaruly on 15.05.2021.
//

import Foundation

struct Profile {
    var email: String
    var firstName: String
    var lastName: String
    var phoneNumber: String
    var favoriteIds: [Int]
    
    init(email: String, firstName: String, lastName: String, phoneNumber: String, favoriteIds: [Int]) {
        self.email = email
        self.firstName = firstName
        self.lastName = lastName
        self.phoneNumber = phoneNumber
        self.favoriteIds = favoriteIds
    }
    
}
