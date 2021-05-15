//
//  FootballPitch.swift
//  SportsBooking
//
//  Created by Tarlan Askaruly on 15.05.2021.
//

import Foundation

struct FootballPitch: Identifiable {
    var id: Int
    var type: String
    var floorMaterial: String
    var lengthInMeters: Int
    var widthInMeters: Int
    var conveniences: [String]
    var pricePerHour: Int
    //var bookings: [Bookings]
    
    init(id: Int, type: String, floorMaterial: String, lengthInMeters: Int, widthInMeters: Int, conveniences: [String], pricePerHour: Int) { //bookings: [Bookings]
        self.id = id
        self.type = type
        self.floorMaterial = floorMaterial
        self.lengthInMeters = lengthInMeters
        self.widthInMeters = widthInMeters
        self.conveniences = conveniences
        self.pricePerHour = pricePerHour
        //self.bookings = bookings
    }
}

