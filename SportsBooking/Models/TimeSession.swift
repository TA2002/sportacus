//
//  TimeSession.swift
//  SportsBooking
//
//  Created by Tarlan Askaruly on 15.05.2021.
//

import Foundation
import SwiftUI

struct Transaction: Identifiable {
    var id: UUID = UUID()
    
    var amount: Int
    var date: String
    var sessions: [TimeSession]
    var footballFacilityId: Int
    
    init(amount: Int, date: String, sessions: [TimeSession], footballFacilityId: Int) {
        self.amount = amount
        self.date = date
        self.sessions = sessions
        self.footballFacilityId = footballFacilityId
    }
    
    func asPropertyList() -> [String: Any] {
        var propertyLists: [[String: Any]] = [[String: Any]]()
        
        for index in (0..<sessions.count) {
            propertyLists.append(sessions[index].asPropertyList())
        }
        
        return ["amount": amount, "date": date, "sessions": propertyLists, "footballFacilityId": footballFacilityId]
    }
    
    init(from dictionary: [String: Any]) {
        print("dictionary \(dictionary)")
        amount = dictionary["amount"] as! Int
        date = dictionary["date"] as! String
        self.sessions = []
        if let transactionSessions = dictionary["sessions"] as? [[String: Int]] {
            for transactionSession in transactionSessions {
                sessions.append(TimeSession(from: transactionSession))
            }
        }
        footballFacilityId = dictionary["footballFacilityId"] as? Int ?? 0
    }
    
}

struct TimeSession: Equatable {
    var startHours: Int
    var startMinutes: Int
    var finishHours: Int
    var finishMinutes: Int
    
    init(startHours: Int, startMinutes: Int, finishHours: Int, finishMinutes: Int) {
        self.startHours = startHours
        self.startMinutes = startMinutes
        self.finishHours = finishHours
        self.finishMinutes = finishMinutes
    }
    
    func asPropertyList() -> [String: Any] {
        return ["startHours": startHours, "startMinutes": startMinutes, "finishHours": finishHours, "finishMinutes": finishMinutes]
    }
    
    init(from dictionary: [String: Int]) {
        startHours = dictionary["startHours"]!
        startMinutes = dictionary["startMinutes"]!
        finishHours = dictionary["finishHours"]!
        finishMinutes = dictionary["finishMinutes"]!
    }
    
}

extension Formatter {
    static let withSeparator: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.groupingSeparator = "."
        formatter.numberStyle = .decimal
        return formatter
    }()
}

extension Int {
    var formattedWithSeparator: String {
        return Formatter.withSeparator.string(for: self) ?? ""
    }
    var timeFormatter: String {
        if self <= 9 {
            return "0\(self)"
        }
        else {
            return "\(self)"
        }
    }
}

extension TimeSession {
    var timeFormatter: String {
        return "\(self.startHours.timeFormatter):\(self.startMinutes.timeFormatter)-\(self.finishHours.timeFormatter):\(self.finishMinutes.timeFormatter)"
    }
}
