//
//  Bookings.swift
//  SportsBooking
//
//  Created by Tarlan Askaruly on 15.05.2021.
//

import Foundation

struct Bookings {
    var date: Date
    
    var bookedSessions: [TimeSession] // time sessions that are already booked
    var closedSessions: [TimeSession] // time sessions closed by the owner of the pitch
    
    init(date: Date, bookedSessions: [TimeSession], closedSessions: [TimeSession]) {
        self.date = date
        self.bookedSessions = bookedSessions
        self.closedSessions = closedSessions
    }
}
