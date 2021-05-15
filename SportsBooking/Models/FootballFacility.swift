//
//  FootballFacility.swift
//  SportsBooking
//
//  Created by Tarlan Askaruly on 14.05.2021.
//

import Foundation

struct FootballFacility: Identifiable {
    var id: Int
    var name: String
    var address: String
    var reviews: [Review] {
        didSet {
            averageRating = 0
            for review in reviews {
                averageRating += Double(review.reviewRating)
            }
            averageRating = averageRating / Double(reviews.count)
        }
    }
    var photoUrls: [URL]
    var schedule: Schedule
    var averageRating: Double
    var footballPitches: [FootballPitch]
    
    init(id: Int, name: String, address: String, reviews: [Review], photoUrls: [URL], schedule: Schedule, footballPitches: [FootballPitch]) {
        self.id = id
        self.name = name
        self.address = address
        self.reviews = reviews
        self.photoUrls = photoUrls
        self.schedule = schedule
        self.footballPitches = footballPitches
        
        averageRating = 0
        for review in reviews {
            averageRating += Double(review.reviewRating)
        }
        averageRating = averageRating / Double(reviews.count)
    }
    
}

