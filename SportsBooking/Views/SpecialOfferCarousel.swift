//
//  SpecialOfferCarousel.swift
//  SportsBooking
//
//  Created by Tarlan Askaruly on 11.05.2021.
//

import SwiftUI

struct SpecialOfferCarousel: View {
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        VStack {
            Image("court")
                .resizable()
                .frame(width: 270, height: 150)
            
            HStack {
                Text("Astana Arena")
                    .bold()
                    .padding(.all, 10)
                Spacer()
            }
            
            HStack {
                Text("Alikhan Bokeikhan 2")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .padding(.leading, 10)
                Spacer()
            }
            
            HStack {
                ForEach(0 ..< 5) { item in
                    Image(systemName: "star.fill")
                        .foregroundColor(.yellow)
                        .font(.subheadline)
                }
                Spacer()
                
                Text("10000 KZT")
                    .font(.subheadline)
                    .bold()
            }
            .padding(.bottom, 30)
            .padding(.leading, 10)
            .padding(.trailing, 10)
            
        }
        .frame(width: 250, height: 250)
        .cornerRadius(10)
        
    }
    
}
