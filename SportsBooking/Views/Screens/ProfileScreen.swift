//
//  ProfileScreen.swift
//  SportsBooking
//
//  Created by Tarlan Askaruly on 26.05.2021.
//

import SwiftUI

struct ProfileScreen: View {
    
    @ObservedObject var userSession: UserSession
    
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                ScrollView {
                    VStack {
                        HStack {
                            ZStack {
                                Circle()
                                    .fill(filterOrangeColor)
                                    .frame(width: 70, height: 70)
                                Text("\(userSession.profile.initials.uppercased())")
                                    .font(.system(size: 27, weight: .light, design: .default))
                                    .foregroundColor(.white)
                            }
                            .padding(.trailing)
                            VStack {
                                HStack {
                                    Text("\(userSession.profile.firstName) \(userSession.profile.firstName)")
                                        .font(.system(size: 17, weight: .semibold, design: .rounded))
                                        .foregroundColor(.black)
                                        .padding(.trailing, 5)
                                    Spacer()
                                }
                                HStack {
                                    Text("\(userSession.profile.transactions.count) бронирований")
                                        .font(.system(size: 17, weight: .regular, design: .default))
                                        .foregroundColor(.secondary)
                                    Spacer()
                                }
                            }
                            Spacer()
                        }
                        HStack {
                            Text("Бонусы")
                                .font(.system(size: nameFontSize, weight: .regular, design: .default))
                            Spacer()
                            Text("0 ₸")
                                .font(.system(size: nameFontSize, weight: .bold, design: .rounded))
                        }
                            .padding(.top, 20)
                        
                        HStack {
                            Text("История")
                                .font(.system(size: customTitleSize, weight: .bold, design: .rounded))
                            Spacer()
                            HStack {
                                Text("Все")
                                    .font(.system(size: customTitleSize - 6, weight: .bold, design: .default))
                                    .foregroundColor(filterOrangeColor)
                            }
                            .padding(10)
                            .fixedSize(horizontal: true, vertical: false)
                            .background(filterOrangeColor.opacity(0.1))
                            .cornerRadius(10)
                        }
                            .padding(.top, 30)
                        
                        ForEach(0..<min(userSession.profile.transactions.count, 3)) { index in //userSession.profile.transactions.count
                            HStack {
                                RemoteImage(url: userSession.footballFacilities[userSession.profile.transactions[index].footballFacilityId].photoUrls.first ?? "", width: 50, height: 50)//(url: "https://image.made-in-china.com/2f0j00BtdUPGNybYkI/Cheaper-Price-Artificial-Grass-for-Outdoor-Football-Court-S50-.jpg")//
                                
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 50 , height: 50)
                                    .cornerRadius(10)
                                    .clipped()
//                                    .aspectRatio(contentMode: .fit)
//                                    .frame(width: 30, height: 30)
//                                    .padding(.trailing)
                                VStack {
                                    HStack {
                                        Text("\(userSession.footballFacilities[userSession.profile.transactions[index].footballFacilityId].name)")//
                                            .font(.system(size: 14, weight: .bold, design: .rounded))
                                            .foregroundColor(Color.black)
                                            .padding(.bottom, 3)
                                        Spacer()
                                        Text("\(userSession.profile.transactions[index].amount) ₸")
                                            .font(.system(size: 14, weight: .bold, design: .rounded))
                                            .foregroundColor(filterOrangeColor)
                                            .padding(.bottom, 3)
                                    }
                                    ForEach(0..<userSession.profile.transactions[index].sessions.count) { sessionIndex in
                                        Text("\(userSession.profile.transactions[index].sessions[sessionIndex].timeFormatter)")
                                            .font(.system(size: 11, weight: .bold, design: .rounded))
                                            .foregroundColor(.secondary)
                                    }
                                }

                            }
                        }
                        
                        //Spacer()
                        Button("Log out", action: {
                            userSession.userDidLogOut()
                        })
                    }
                }
                .padding(.top)
                .padding(.horizontal, cellHorizontalPadding)
                .navigationTitle(Text("Привет \(userSession.profile.firstName)!"))
            }
        }
    }
    
    private var customTitleSize: CGFloat {
        max(UIScreen.main.bounds.height / 40, 18)
    }
    
    private var nameFontSize: CGFloat {
        max((UIScreen.main.bounds.height) / 55, 15)
    }
    
    private var reviewsFontSize: CGFloat {
        max((UIScreen.main.bounds.height) / 65, 13)
    }
    
    private var cellHorizontalPadding: CGFloat {
        UIScreen.main.bounds.width*0.05
    }

}

struct ProfileScreen_Previews: PreviewProvider {
    static var previews: some View {
        ProfileScreen(userSession: UserSession())
    }
}
