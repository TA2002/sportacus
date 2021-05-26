//
//  HomeScreen.swift
//  SportsBooking
//
//  Created by Tarlan Askaruly on 11.05.2021.
//

import SwiftUI
import Firebase
import ActivityIndicatorView

struct HomeScreen: View {
    @ObservedObject var userSession: UserSession
    @Environment(\.colorScheme) var colorScheme
    
    @State private var showCancelButton: Bool = false
    @State private var specialOffers: [String] = ["СТО футбол", "Astana Arena", "Manchester United"]
    
    private var cellImageWidth: CGFloat {
        UIScreen.main.bounds.width*0.9
    }
    
    private var cellHorizontalPadding: CGFloat {
        UIScreen.main.bounds.width*0.05
    }
    
    @State var lunbo_img_index: Int = 0
    @State var show_img_detail: Bool = false
    
    let images: [Image] = [Image("court"), Image("court"), Image("court")]
    
    @State var isFavorite: Bool = false

    init(userSession: UserSession) {
        //UINavigationBar.appearance().backgroundColor = .clear
        self.userSession = userSession
//        UINavigationBar.appearance().backgroundColor = .white
        
        
        //UINavigationBar.appearance().backgroundColor = .white
    }
    
    @State var searchBarText: String = ""
    @State private var showLoadingIndicator: Bool = true
    
    private var customTitleSize: CGFloat {
        UIScreen.main.bounds.width / 20
    }
    
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                ZStack {
                    //Color.init(hex: "#f3f4f6").ignoresSafeArea(.all)
                    Color.white
                    
                    VStack() {
                        //CustomNavigationBar(searchBarText: $searchBarText)
                        
                        
                        ScrollView(showsIndicators: false) {
                            
                            HStack {
                                Text("АКЦИИ")
                                    .font(.system(size: customTitleSize, weight: .bold, design: .rounded))
                                    .foregroundColor(Color.black)
                                    .multilineTextAlignment(.trailing)
                                    .padding(.leading, cellHorizontalPadding)

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
                                .padding(.trailing, cellHorizontalPadding)
                            }
                            .padding(.top)
                            
                            Group {
                                if userSession.footballFacilities.count > 0 {
                                    ScrollView(.horizontal, showsIndicators: false) {
                                        HStack(spacing: 0) {
                                            ForEach(0..<7) { card in
                                                SpecialOfferCarousel()
                                                    .background(colorScheme == .dark ? Color.black.opacity(1) : Color.white.opacity(1))
                                                    .cornerRadius(15)
                                                    .shadow(color: colorScheme == .dark ? Color.white : Color.black.opacity(0.4), radius: 2)
                                                    .buttonStyle(PlainButtonStyle())
                                                    .padding(.leading, card == 0 ? cellHorizontalPadding : 10)
                                            }
                                            

                                        }
                                        .padding(.top, 10)
                                    }
                                }
                                else {
                                    ZStack {
                                        Rectangle().fill(Color.white)
                                        ActivityIndicatorView(isVisible: self.$showLoadingIndicator, type: .default)
                                                                .frame(width: 30, height: 30)
                                                                .foregroundColor(.red)
                                    }
                                }
                            }
                            
                            HStack {
                                Text("ПОПУЛЯРНЫЕ")
                                    .font(.system(size: customTitleSize, weight: .bold, design: .rounded))
                                    .foregroundColor(Color.black)
                                    .multilineTextAlignment(.trailing)
                                    .padding(.leading, cellHorizontalPadding)

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
                                .padding(.trailing, cellHorizontalPadding)
                            }
                            .padding(.top)

                            Group {
                                if userSession.footballFacilities.count > 0 {
                                    VStack(alignment: .center) {
                                        ForEach(0..<userSession.footballFacilities.count + 1, id: \.self) { index in
                                            NavigationLink(destination: DetailsScreen(userSession: userSession, footballFacility: userSession.footballFacilities[index / 2], for: geometry.size)) {
                                                FieldsListCell(footballFacility: userSession.footballFacilities[index / 2], size: geometry.size, userSession: userSession)
                                                    .padding(.horizontal, cellHorizontalPadding)
                                                    .padding(.top, 10)
                                                    .padding(.bottom, 10)
                                            }
                                            
                                        }
                                    }
                                }
                                else {
                                    ZStack {
                                        Rectangle().fill(Color.white)
                                        ActivityIndicatorView(isVisible: self.$showLoadingIndicator, type: .default)
                                                                .frame(width: 30, height: 30)
                                                                .foregroundColor(.red)
                                    }
                                }
                            }
                        }
                        
                    }
                }
                //.navigationBarTitleDisplayMode(.inline)
                .navigationTitle(Text("Главная"))
                .navigationBarItems(leading: HStack {
                    Image("placeholder")
                        .resizable()
                        .renderingMode(.template)
                        .scaledToFill()
                        .frame(width: 20, height: 20)
                        .foregroundColor(filterOrangeColor)
                    Text("Нур-Султан ")
                        .font(.system(size: 14, weight: .semibold, design: .default))
                        .foregroundColor(filterOrangeColor)
                    Image(systemName: "chevron.down")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 6, height: 6)
                        .foregroundColor(filterOrangeColor)
                    
                })
                //.navigationBarHidden(true)
            }
        }
    }
    
    private func computedTopPadding(for size: CGSize) -> CGFloat {
        size.height * 0.1
    }
    
}

struct CustomNavigationBar: View {
    
    @Binding var searchBarText: String
    
    private var cellHorizontalPadding: CGFloat {
        UIScreen.main.bounds.width*0.05
    }
    
    var body: some View {
        //RoundedImage()
        
//        SearchBar(text: $searchBarText).padding(.horizontal, cellHorizontalPadding).padding(.top, -20)
//            .padding(.top, 25)
        
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 5) {
                Button(action: {
                    
                }, label: {
                    HStack {
                        Image(systemName: "slider.horizontal.3")
                            .font(.system(size: 15, weight: .bold, design: .default))
                        Text("Фильтры")
                            .font(.system(size: 14, weight: .light, design: .default))
                    }
                    .padding(7)
                    .fixedSize(horizontal: true, vertical: false)
                    .foregroundColor(.white)
                    .background(filterOrangeColor)
                    .cornerRadius(4)
                    
                })
                Button(action: {
                    
                }, label: {
                    HStack {
                        Text("Избранные")
                            .font(.system(size: 14, weight: .light, design: .default))
                        Image(systemName: "heart.fill")
                            .font(.system(size: 15, weight: .bold, design: .default))
                    }
                    .padding(7)
                    .fixedSize(horizontal: true, vertical: false)
                    .foregroundColor(.black)
                    .background(Color.white)
                    .cornerRadius(4)
                })
                Button(action: {
                    
                }, label: {
                    HStack {
                        Text("Поблизости")
                            .font(.system(size: 14, weight: .light, design: .default))
                        Image(systemName: "antenna.radiowaves.left.and.right")
                            .font(.system(size: 15, weight: .bold, design: .default))
                    }
                    .padding(7)
                    .fixedSize(horizontal: true, vertical: false)
                    .foregroundColor(.black)
                    .background(Color.white)
                    .cornerRadius(4)
                })
            }
            .padding(.leading, cellHorizontalPadding)
        }.padding(.bottom, 5)
    }
    
}


func hexStringToUIColor (hex:String) -> UIColor {
    var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

    if (cString.hasPrefix("#")) {
        cString.remove(at: cString.startIndex)
    }

    if ((cString.count) != 6) {
        return UIColor.gray
    }

    var rgbValue:UInt64 = 0
    Scanner(string: cString).scanHexInt64(&rgbValue)

    return UIColor(
        red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
        green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
        blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
        alpha: CGFloat(1.0)
    )
}
