//
//  SpecialOfferCarousel.swift
//  SportsBooking
//
//  Created by Tarlan Askaruly on 11.05.2021.
//

import SwiftUI

struct SpecialOfferCarousel: View {
    @Environment(\.colorScheme) var colorScheme
    
    var imageWidth: CGFloat {
        UIScreen.main.bounds.width*0.8
    }
    
    var body: some View {
        ZStack(alignment: .center) {
            Image("court")
                .resizable()
                .scaledToFill()
                .frame(width: imageWidth, height: imageWidth * 0.6)
                .clipped()
                .opacity(0.9)
            VStack {
                Text("Football Life")
                    .font(.system(size:  28, weight: .bold, design: .rounded))
                    .foregroundColor(Color.white)
                    .shadow(color: Color.black, radius: 5, x: 1, y: 2)
                Text("-50%")
                    .font(.system(size:  20, weight: .bold, design: .rounded))
                    .foregroundColor(Color.white)
                    .shadow(color: Color.black, radius: 5, x: 1, y: 2)
            }
            
        }
        
        .cornerRadius(10)
        
    }
    
}
