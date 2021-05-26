//
//  BottomCheckOutView.swift
//  SportsBooking
//
//  Created by Tarlan Askaruly on 20.05.2021.
//

import SwiftUI
import SwiftDate

struct BottomCheckOutView: View {
    
    @ObservedObject private var userSession: UserSession
    
    @Binding private var sessionsToBuy: [TimeSession]
    
    private var footballPitch: FootballPitch
    private var footballFacility: FootballFacility
    private var dateForBooking: DateInRegion
    
    init(userSession: UserSession, sessionsToBuy: Binding<[TimeSession]>, footballPitch: FootballPitch, footballFacility: FootballFacility, dateForBooking: DateInRegion) {
        self.userSession = userSession
        self._sessionsToBuy = sessionsToBuy
        self.footballPitch = footballPitch
        self.footballFacility = footballFacility
        self.dateForBooking = dateForBooking
    }
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        Group {
            if sessionsToBuy.count > 0 {
                ZStack(alignment: .bottom) {
                    Rectangle()
                        .fill(Color.white)
                        .cornerRadius(20)
                        .shadow(color: .black, radius: 10, x: 0, y: -1)
                        
                        
                    VStack(spacing: 0) {
                        
                        HStack {
                            Text("К оплате:")
                            Text("\((footballPitch.pricePerHour / 2 * sessionsToBuy.count).formattedWithSeparator)₸")
                                .bold()
                            Spacer()
                            Text("Отменить")
                                .onTapGesture {
                                    sessionsToBuy = []
                                }
                        }
                        .padding(.top)
                        .padding(.bottom, 5)
                        .padding(.horizontal, cellHorizontalPadding)
                        
                        HStack {
                            Text("Выбранные сеансы на \(dateForBooking.dayAndMonth): ")
                                .font(.system(size: self.customSize, weight: .light, design: .default))
                            Spacer()
                        }
                        .padding(.horizontal, cellHorizontalPadding)
                        
                        LazyVGrid(columns: columns, spacing: 0) {
                            ForEach(0..<sessionsToBuy.count, id: \.self) { sessionIndex in
                                Text(sessionsToBuy[sessionIndex].timeFormatter)
                                    .font(.system(size: self.customSize - 2, weight: .semibold, design: .default))
                            }
                        }
                        .padding(.bottom)
                        .padding(.horizontal, cellHorizontalPadding)
                        
                        Button(action: {
                            bookSessions(footballFacilityId: footballFacility.id, footballPitchId: footballPitch.id, date: dateForBooking, sessionsForBooking: sessionsToBuy)
                        }, label: {
                            Text("Оплатить")
                                .bold()
                                .foregroundColor(.white)
                                .padding(.vertical, 20)
                                .padding(.horizontal, cellHorizontalPadding)
                        })
                            .frame(width: UIScreen.main.bounds.width * 0.9)
                            .background(filterOrangeColor)
                            .cornerRadius(8)
                            .padding(.horizontal, cellHorizontalPadding)
                            .padding(.bottom, 25)
                    }
                    
                }
                .fixedSize(horizontal: false, vertical: true)
                .transition(.slide)
                .animation(.default)
            }
        }
    }
    
    func bookSessions(footballFacilityId: Int, footballPitchId: Int, date: DateInRegion, sessionsForBooking: [TimeSession]) {
        userSession.bookSession(footballPitchPricePerHour: footballPitch.pricePerHour, footballFacilityId: footballFacilityId, footballPitchId: footballPitchId, date: date, sessionsForBooking: sessionsForBooking)
        sessionsToBuy = []
    }
    
    private var cellHorizontalPadding: CGFloat {
        UIScreen.main.bounds.width*0.05
    }
    
    private var customTitleSize: CGFloat {
        max(UIScreen.main.bounds.height / 37 - 3, 18)
    }
    
    private var customSize: CGFloat {
        max((UIScreen.main.bounds.height) / 55, 13)
    }
    
}
