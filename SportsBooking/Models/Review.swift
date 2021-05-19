//
//  Review.swift
//  SportsBooking
//
//  Created by Tarlan Askaruly on 15.05.2021.
//

import Foundation

struct Review {
    var reviewContent: String
    var reviewRating: Int
    
    init(reviewContent: String, reviewRating: Int) {
        self.reviewContent = reviewContent
        self.reviewRating = reviewRating
    }
    
}


