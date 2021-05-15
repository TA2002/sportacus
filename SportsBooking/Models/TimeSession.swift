//
//  TimeSession.swift
//  SportsBooking
//
//  Created by Tarlan Askaruly on 15.05.2021.
//

import Foundation

struct TimeSession {
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
    
}
