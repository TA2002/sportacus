//
//  HorizontalDatePicker.swift
//  SportsBooking
//
//  Created by Tarlan Askaruly on 19.05.2021.
//

import SwiftUI

struct HorizontalDatePicker: View {
    @Binding var dayIndex: Int
    @Binding var sessionsToBuy: [TimeSession]
    @ObservedObject var userSession: UserSession

    var footballFacility: FootballFacility
    var footballPitch: FootballPitch
    
    private var customSize: CGFloat {
        max((UIScreen.main.bounds.height) / 55, 13)
    }
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 0) {
                ForEach(0..<userSession.datesForBooking!.count, id: \.self){ index in
                    Button(action: {
                        self.dayIndex = index
                        self.sessionsToBuy = []
                        userSession.downloadClosedSessions(footballFacilityId: footballFacility.id, footballPitchId: footballPitch.id, date: userSession.datesForBooking![dayIndex])
                    }, label: {
                        VStack {
                            Text("\(self.userSession.datesForBooking![index].withoutTime)")
                                .font(.system(size: self.customSize, weight: .semibold, design: .default))
                                .foregroundColor(index == self.dayIndex ? Color.white : Color.black)
                                .padding(.horizontal)
                                .padding(.top)
                            Text("\(self.userSession.datesForBooking![index].dayAndMonth)")
                                .font(.system(size: self.customSize - 2, weight: .light, design: .default))
                                .foregroundColor(index == self.dayIndex ? Color.white : Color.black)
                                .padding(.horizontal)
                                .padding(.bottom)
                            
                        }
                    })
                    .background(index == self.dayIndex ? filterOrangeColor : bgHexColor)
                    .cornerRadius(10)
                    .padding(.leading)
                }
            }
        }
    }
    
}
