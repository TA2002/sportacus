//
//  Schedule.swift
//  SportsBooking
//
//  Created by Tarlan Askaruly on 15.05.2021.
//

import Foundation

struct Schedule {
    var workdays: TimeSession
    var saturday: TimeSession
    var sunday: TimeSession
    
    init(workdays: TimeSession, saturday: TimeSession, sunday: TimeSession) {
        self.workdays = workdays
        self.saturday = saturday
        self.sunday = sunday
    }
}
