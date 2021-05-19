//
//  BookingScreen.swift
//  SportsBooking
//
//  Created by Tarlan Askaruly on 13.05.2021.
//

import Foundation
import SwiftUI
import SwiftDate

struct ShowingSheetKey: EnvironmentKey {
    static let defaultValue: Binding<Bool>? = nil
}

extension EnvironmentValues {
    var showingSheet: Binding<Bool>? {
        get { self[ShowingSheetKey.self] }
        set { self[ShowingSheetKey.self] = newValue }
    }
}

struct BookingScreen: View {
    
    @Environment(\.showingSheet) var sheetIsPresented
    @ObservedObject private var userSession: UserSession
    
    @State var dayIndex = 0
    
    @State private var sessionsToBuy: [TimeSession] = [TimeSession]()
    
    private var footballFacility: FootballFacility
    private var footballPitch: FootballPitch
    
    private var customSize: CGFloat {
        max((UIScreen.main.bounds.height) / 55, 13)
    }
    
    init(userSession: UserSession, footballFacility: FootballFacility, footballPitch: FootballPitch) {
        self.userSession = userSession
        self.footballPitch = footballPitch
        self.footballFacility = footballFacility
    }
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button(action: {
                    self.sheetIsPresented?.wrappedValue = false
                }, label: {
                    Text("Закрыть")
                        .font(.system(size: customSize, weight: .semibold, design: .default))
                })
            }
            .padding()
            Group {
                if let datesForBooking = userSession.datesForBooking {
                    if userSession.availableTimeSessionsForBooking.count == 7 {
                        VStack {
                            HorizontalDatePicker(dayIndex: $dayIndex, sessionsToBuy: $sessionsToBuy, userSession: userSession, footballFacility: footballFacility, footballPitch: footballPitch)
                            Text("Выберите время")
                                .font(.system(size: customSize, weight: .regular, design: .default))
                                .padding()
                            ScrollView {
                                VStack {
                                    //userSession.availableTimeSessionsForBooking["\(datesForBooking[dayIndex].day).\(datesForBooking[dayIndex].month).\(datesForBooking[dayIndex].year)"].count
                                    //userSession.availableTimeSessionsForBooking["\(datesForBooking![dayIndex].day).\(datesForBooking![dayIndex].month).\(datesForBooking![dayIndex].year)"]
                                    ForEach(0..<userSession.sessionsFor(date: datesForBooking[dayIndex]).count, id: \.self) { index in
                                        Button(action: {
                                            if let closedSessions = userSession.closedTimesSessions {
                                                if closedSessions.contains(userSession.sessionsFor(date: datesForBooking[dayIndex])[index]) {
                                                    if sessionsToBuy.contains(userSession.sessionsFor(date: datesForBooking[dayIndex])[index]) {
                                                        sessionsToBuy.remove(at: sessionsToBuy.firstIndex(of: userSession.sessionsFor(date: datesForBooking[dayIndex])[index])!)
                                                    }
                                                }
                                                else if sessionsToBuy.contains(userSession.sessionsFor(date: datesForBooking[dayIndex])[index]) {
                                                    sessionsToBuy.remove(at: sessionsToBuy.firstIndex(of: userSession.sessionsFor(date: datesForBooking[dayIndex])[index])!)
                                                }
                                                else {
                                                    sessionsToBuy.append(userSession.sessionsFor(date: datesForBooking[dayIndex])[index])
                                                }
                                            }
                                            else {
                                                sessionsToBuy = []
                                            }
                                            
                                        }, label: {
                                            HStack {
                                                Text(userSession.sessionsFor(date: datesForBooking[dayIndex])[index].timeFormatter)
                                                    .font(.system(size: customSize, weight: .semibold, design: .default))
                                                    .foregroundColor(blackColor)
                                                    .padding()
                                                Spacer()
                                                Group {
                                                    if let closedSessions = userSession.closedTimesSessions {
                                                        if closedSessions.contains(userSession.sessionsFor(date: datesForBooking[dayIndex])[index]) {
                                                            Text("Недоступно")
                                                                .font(.system(size: customSize, weight: .semibold, design: .default))
                                                                .foregroundColor(.black)
                                                                .padding()
                                                        }
                                                        else if sessionsToBuy.contains(userSession.sessionsFor(date: datesForBooking[dayIndex])[index]) {
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
                            .layoutPriority(1)
                            
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
                                                Text("Выбранные сеансы на \(datesForBooking[dayIndex].dayAndMonth): ")
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
                                                bookSessions(footballFacilityId: footballFacility.id, footballPitchId: footballPitch.id, date: datesForBooking[dayIndex], sessionsForBooking: sessionsToBuy)
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
                                    .edgesIgnoringSafeArea(.all)
                                    .fixedSize(horizontal: false, vertical: true)
                                    .transition(.slide)
                                    .animation(.default)
                                }
                            }
                            
                        }
                    }
                }
            }
        }
    }
    
    func bookSessions(footballFacilityId: Int, footballPitchId: Int, date: DateInRegion, sessionsForBooking: [TimeSession]) {
        userSession.bookSession(footballFacilityId: footballFacilityId, footballPitchId: footballPitchId, date: date, sessionsForBooking: sessionsForBooking)
        sessionsToBuy = []
    }
    
    private var cellHorizontalPadding: CGFloat {
        UIScreen.main.bounds.width*0.05
    }
    
    private var customTitleSize: CGFloat {
        max(UIScreen.main.bounds.height / 37 - 3, 18)
    }
    
}

//struct BookingScreen: View {
    //private let bookingSession: [String] = ["00:00-00:30", "00:30-01:00", "01:00-01:30", "00:00-00:30", "00:30-01:00", "01:00-01:30", "00:00-00:30", "00:30-01:00", "01:00-01:30"]
    //@State private var isChosen: [Bool] = [false, false, false, false, false, false, false, false, false]
    //@Environment(\.colorScheme) var colorScheme
//    @ObservedObject private var userSession: UserSession
//
////    let columns = [
////        GridItem(.adaptive(minimum: 100)),
////        GridItem(.adaptive(minimum: 100)),
////        GridItem(.adaptive(minimum: 100)),
////    ]
//
//    @State var dayIndex = 0
//    private var footballFacility: FootballFacility
//    private var footballPitch: FootballPitch
//
//    private var customSize: CGFloat {
//        max((UIScreen.main.bounds.height) / 50, 15)
//    }
//
//    var body: some View {
//        VStack {
//            HStack() {
//                ScrollView(.horizontal) {
//                    ForEach(0..<userSession.datesForBooking!.count, id: \.self){ index in
//                        Button(action: {
//                            dayIndex = index
//                        }, label: {
//                            Text("hey")
//                            //                                    .font(.system(size: customSize, weight: .semibold, design: .default))
//                            //                                    .foregroundColor(index == dayIndex ? Color.white : Color.black)
//                                .padding()
//                        })
//                        .background(index == dayIndex ? filterOrangeColor : bgHexColor)
//                        .cornerRadius(10)
//                    }
//                }
//            }
//            .padding(.horizontal)
//        }
//        .onAppear() {
//            userSession.createNewBookingSession(footballFacility: footballFacility, footballPitch: footballPitch)
//        }
        
//    }
//
//}

extension View {
     public func addBorder<S>(_ content: S, width: CGFloat = 1, cornerRadius: CGFloat) -> some View where S : ShapeStyle {
         let roundedRect = RoundedRectangle(cornerRadius: cornerRadius)
         return clipShape(roundedRect)
              .overlay(roundedRect.strokeBorder(content, lineWidth: width))
     }
 }


//LazyVGrid(columns: columns, spacing: 20) {
//    ForEach(0..<bookingSession.count) { index in
//        ZStack {
//            RoundedRectangle(cornerRadius: 5).frame(height: 50).foregroundColor(Color(#colorLiteral(red: 0.9580881, green: 0.10593573, blue: 0.3403331637, alpha: 1)))
//                .addBorder(colorScheme == .dark ? Color(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)) : Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)), width: isChosen[index] ? 2 : 0, cornerRadius: 5)
//            Text(bookingSession[index]).bold().foregroundColor(colorScheme == .dark ? Color.white : Color.white)
//        }//.opacity(isChosen[index] ? 1: 0.7)
//        .onTapGesture {
//            isChosen[index] = !isChosen[index]
//        }
//    }
//}
//.padding(.horizontal)
