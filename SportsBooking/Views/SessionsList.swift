//
//  SessionsList.swift
//  SportsBooking
//
//  Created by Tarlan Askaruly on 20.05.2021.
//

import SwiftUI
import SwiftDate

struct SessionsList: View {
    @ObservedObject private var userSession: UserSession
    @Binding private var sessionsToBuy: [TimeSession]
    
    private var dateForBooking: DateInRegion
    private var footballPitch: FootballPitch
    
    init(userSession: UserSession, sessionsToBuy: Binding<[TimeSession]>, dateForBooking: DateInRegion, footballPitch: FootballPitch) {
        self.userSession = userSession
        self._sessionsToBuy = sessionsToBuy
        self.dateForBooking = dateForBooking
        self.footballPitch = footballPitch
    }
    
    
    var body: some View {
        ScrollView {
            VStack {
                ForEach(0..<userSession.sessionsFor(date: dateForBooking).count, id: \.self) { index in
                    Button(action: {
                        if let closedSessions = userSession.closedTimesSessions {
                            if closedSessions.contains(userSession.sessionsFor(date: dateForBooking)[index]) {
                                if sessionsToBuy.contains(userSession.sessionsFor(date: dateForBooking)[index]) {
                                    sessionsToBuy.remove(at: sessionsToBuy.firstIndex(of: userSession.sessionsFor(date: dateForBooking)[index])!)
                                }
                            }
                            else if sessionsToBuy.contains(userSession.sessionsFor(date: dateForBooking)[index]) {
                                sessionsToBuy.remove(at: sessionsToBuy.firstIndex(of: userSession.sessionsFor(date: dateForBooking)[index])!)
                            }
                            else {
                                sessionsToBuy.append(userSession.sessionsFor(date: dateForBooking)[index])
                            }
                        }
                        else {
                            sessionsToBuy = []
                        }
                        
                    }, label: {
                        HStack {
                            Text(userSession.sessionsFor(date: dateForBooking)[index].timeFormatter)
                                .font(.system(size: customSize, weight: .semibold, design: .default))
                                .foregroundColor(blackColor)
                                .padding()
                            Spacer()
                            Group {
                                if let closedSessions = userSession.closedTimesSessions {
                                    if closedSessions.contains(userSession.sessionsFor(date: dateForBooking)[index]) {
                                        Text("Недоступно")
                                            .font(.system(size: customSize, weight: .semibold, design: .default))
                                            .foregroundColor(.black)
                                            .padding()
                                    }
                                    else if sessionsToBuy.contains(userSession.sessionsFor(date: dateForBooking)[index]) {
                                        Image(systemName: "checkmark")
                                            .font(.system(size: customSize, weight: .semibold, design: .default))
                                            .foregroundColor(.green)
                                            .padding()
                                    }
                                    else {
                                        Text("\((footballPitch.pricePerHour / 2).formattedWithSeparator)₸")
                                            .font(.system(size: customSize, weight: .semibold, design: .default))
                                            .foregroundColor(.green)
                                            .padding()
                                    }
                                }
                                
                            }
                            
                        }
                        
                    })
                    //.background()
                }
            }
        }
    }
    
    private var customSize: CGFloat {
        max((UIScreen.main.bounds.height) / 55, 13)
    }
    
}
