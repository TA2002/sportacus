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
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
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
    
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                Group {
                    if let datesForBooking = userSession.datesForBooking {
                        if userSession.availableTimeSessionsForBooking.count == 7 {
                            VStack {
                                HStack {
                                    Text("Сеансы")
                                        .foregroundColor(blackColor)
                                        .bold()
                                        .font(.title)
                                    Spacer()
                                }
                                
                                
                                    .padding(.top, geometry.safeAreaInsets.top * 0.8)
                                    .padding(.horizontal)
                                
                                HorizontalDatePicker(dayIndex: $dayIndex, sessionsToBuy: $sessionsToBuy, userSession: userSession, footballFacility: footballFacility, footballPitch: footballPitch)
                                    
                                    
                                Text("Выберите время")
                                    .font(.system(size: customSize, weight: .regular, design: .default))
                                    .padding()
                                    
                                    
                                
                                SessionsList(userSession: userSession, sessionsToBuy: $sessionsToBuy, dateForBooking: datesForBooking[dayIndex], footballPitch: footballPitch)
                                    .layoutPriority(1)
                                    
                                    
                                
                                BottomCheckOutView(userSession: userSession, sessionsToBuy: $sessionsToBuy, footballPitch: footballPitch, footballFacility: footballFacility, dateForBooking: datesForBooking[dayIndex])
                                
                                
                            }
                            .edgesIgnoringSafeArea(.top)
                        }
                    }
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(
            leading: ZStack(alignment: .center) {
                HStack {
                    Image(systemName: "chevron.left")
                        .imageScale(.large)
                        .foregroundColor(blackColor)
                    Text(footballFacility.name)
                        .bold()
                        .foregroundColor(blackColor)
                }
            }.onTapGesture {
                presentationMode.wrappedValue.dismiss()
            }
        )
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
