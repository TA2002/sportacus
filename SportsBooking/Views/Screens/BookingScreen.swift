//
//  BookingScreen.swift
//  SportsBooking
//
//  Created by Tarlan Askaruly on 13.05.2021.
//

import Foundation
import SwiftUI

struct BookingScreen: View {
    private let bookingSession: [String] = ["00:00-00:30", "00:30-01:00", "01:00-01:30", "00:00-00:30", "00:30-01:00", "01:00-01:30", "00:00-00:30", "00:30-01:00", "01:00-01:30"]
    @State private var isChosen: [Bool] = [false, false, false, false, false, false, false, false, false]
    @Environment(\.colorScheme) var colorScheme
    
    let columns = [
        GridItem(.adaptive(minimum: 100)),
        GridItem(.adaptive(minimum: 100)),
        GridItem(.adaptive(minimum: 100)),
    ]
    
    var body: some View {
        Text("demo")
        ScrollView {
            LazyVGrid(columns: columns, spacing: 20) {
                ForEach(0..<bookingSession.count) { index in
                    ZStack {
                        RoundedRectangle(cornerRadius: 5).frame(height: 50).foregroundColor(Color(#colorLiteral(red: 0.9580881, green: 0.10593573, blue: 0.3403331637, alpha: 1)))
                            .addBorder(colorScheme == .dark ? Color(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)) : Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)), width: isChosen[index] ? 2 : 0, cornerRadius: 5)
                        Text(bookingSession[index]).bold().foregroundColor(colorScheme == .dark ? Color.white : Color.white)
                    }//.opacity(isChosen[index] ? 1: 0.7)
                    .onTapGesture {
                        isChosen[index] = !isChosen[index]
                    }
                }
            }
            .padding(.horizontal)
        }
    }
    
}

extension View {
     public func addBorder<S>(_ content: S, width: CGFloat = 1, cornerRadius: CGFloat) -> some View where S : ShapeStyle {
         let roundedRect = RoundedRectangle(cornerRadius: cornerRadius)
         return clipShape(roundedRect)
              .overlay(roundedRect.strokeBorder(content, lineWidth: width))
     }
 }
