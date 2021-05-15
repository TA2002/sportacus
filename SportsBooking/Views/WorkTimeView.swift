//
//  WorkTimeView.swift
//  SportsBooking
//
//  Created by Tarlan Askaruly on 14.05.2021.
//

import SwiftUI

struct WorkTimeView: View {
    
    var body: some View {
        VStack {
            HStack {
                Text("Пн-Пт")
                    .font(.system(size: customSize, weight: .regular, design: .default)).foregroundColor(blackColor)
                Spacer()
                Text("08:00-21:00")
                    .font(.system(size: customSize, weight: .regular, design: .default)).foregroundColor(blackColor)
            }
            
            HStack {
                Text("Суббота")
                    .font(.system(size: customSize, weight: .regular, design: .default)).foregroundColor(blackColor)
                Spacer()
                Text("08:00-21:00")
                    .font(.system(size: customSize, weight: .regular, design: .default)).foregroundColor(blackColor)
            }
            HStack {
                Text("Воскресенье")
                    .font(.system(size: customSize, weight: .regular, design: .default)).foregroundColor(blackColor)
                Spacer()
                Text("08:00-21:00")
                    .font(.system(size: customSize, weight: .regular, design: .default)).foregroundColor(blackColor)
            }
        }
    }
    
    private var customSize: CGFloat {
        max((UIScreen.main.bounds.height) / 50, 15)
    }
    
}
