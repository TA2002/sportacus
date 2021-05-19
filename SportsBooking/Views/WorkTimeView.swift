//
//  WorkTimeView.swift
//  SportsBooking
//
//  Created by Tarlan Askaruly on 14.05.2021.
//

import SwiftUI

struct WorkTimeView: View {
    
    private var schedule: Schedule
    
    init(schedule: Schedule) {
        self.schedule = schedule
    }
    
    var body: some View {
        VStack {
            HStack {
                Text("Пн-Пт")
                    .font(.system(size: customSize, weight: .regular, design: .default)).foregroundColor(blackColor)
                Spacer()
                Text("\(schedule.workdays.timeFormatter)")
                    .font(.system(size: customSize, weight: .regular, design: .default)).foregroundColor(blackColor)
            }
            
            HStack {
                Text("Суббота")
                    .font(.system(size: customSize, weight: .regular, design: .default)).foregroundColor(blackColor)
                Spacer()
                Text("\(schedule.saturday.timeFormatter)")
                    .font(.system(size: customSize, weight: .regular, design: .default)).foregroundColor(blackColor)
            }
            HStack {
                Text("Воскресенье")
                    .font(.system(size: customSize, weight: .regular, design: .default)).foregroundColor(blackColor)
                Spacer()
                Text("\(schedule.sunday.timeFormatter)")
                    .font(.system(size: customSize, weight: .regular, design: .default)).foregroundColor(blackColor)
            }
        }
    }
    
    private var customSize: CGFloat {
        max((UIScreen.main.bounds.height) / 50, 15)
    }
    
}

