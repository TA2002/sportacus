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
    var transactions: [Transaction]
    
    init(email: String, firstName: String, lastName: String, phoneNumber: String, favoriteIds: [Int], transactions: [Transaction]) {
        self.email = email
        self.firstName = firstName
        self.lastName = lastName
        self.phoneNumber = phoneNumber
        self.favoriteIds = favoriteIds
        self.transactions = transactions
    }
    
}

extension Profile {
    var initials: String {
        self.firstName.count > 0 && self.lastName.count > 0 ? String("\(self.firstName[0...0])\(self.lastName[0...0])") : ""
    }
}

extension String {
    subscript (bounds: CountableClosedRange<Int>) -> String {
        let start = index(startIndex, offsetBy: bounds.lowerBound)
        let end = index(startIndex, offsetBy: bounds.upperBound)
        return String(self[start...end])
    }

    subscript (bounds: CountableRange<Int>) -> String {
        let start = index(startIndex, offsetBy: bounds.lowerBound)
        let end = index(startIndex, offsetBy: bounds.upperBound)
        return String(self[start..<end])
    }
}
