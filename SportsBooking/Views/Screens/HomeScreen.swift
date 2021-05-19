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
        UINavigationBar.appearance().backgroundColor = .clear
        self.userSession = userSession
    }
    
    @State var searchBarText: String = ""
    @State private var showLoadingIndicator: Bool = true
    
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                ZStack {
                    Color.init(hex: "#f3f4f6").ignoresSafeArea(.all)
                    VStack() {
                        CustomNavigationBar(searchBarText: $searchBarText)
                        
                        Group {
                            if userSession.footballFacilities.count > 0 {
                                ScrollView(showsIndicators: false) {
                                    VStack(alignment: .center) {
                                        ForEach(0..<userSession.footballFacilities.count, id: \.self) { index in
                                            NavigationLink(destination: DetailsScreen(userSession: userSession, footballFacility: userSession.footballFacilities[index], for: geometry.size)) {
                                                FieldsListCell(footballFacility: userSession.footballFacilities[index], size: geometry.size, userSession: userSession)
                                                    .padding(.horizontal, cellHorizontalPadding)
                                                    .padding(.top, 10)
                                            }
                                        }
                                    }
                                    
                                }
                            }
                            else {
                                ZStack {
                                    Rectangle().fill(bgHexColor)
                                    ActivityIndicatorView(isVisible: self.$showLoadingIndicator, type: .default)
                                                            .frame(width: 30, height: 30)
                                                            .foregroundColor(.red)
                                }
                            }
                        }
                        
                        
                    }
                }
                .navigationBarHidden(true)
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
        RoundedImage()
        
        SearchBar(text: $searchBarText).padding(.horizontal, cellHorizontalPadding).padding(.top, -20)
        
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

//var body: some View {
//    NavigationView {
//        GeometryReader { geometry in
//            ScrollView(showsIndicators: false) {
//                VStack{
//                    SearchBar().padding(.top, -computedTopPadding(for: geometry.size) * 0.5)
//                    VStack {
//                        HStack {
//                            Text("Горячие предложения")
//                                .bold()
//                                .multilineTextAlignment(.trailing)
//                                .padding(.leading, 20)
//
//                            Spacer()
//                            Text("Посмотреть все >")
//                                .multilineTextAlignment(.leading)
//                                .foregroundColor(Color(#colorLiteral(red: 0.9580881, green: 0.10593573, blue: 0.3403331637, alpha: 1)))
//                                .font(.subheadline)
//                                .padding(.trailing, 20)
//                        }
//
//                        ScrollView(.horizontal, showsIndicators: false) {
//                            HStack {
//                                ForEach(0..<7) { card in
//                                    NavigationLink(
//                                        destination: DetailsScreen(for: geometry.size),
//                                        label: {
//                                            SpecialOfferCarousel()
//                                                .background(colorScheme == .dark ? Color.black.opacity(1) : Color.white.opacity(1))
//                                                .cornerRadius(15)
//                                                .shadow(color: colorScheme == .dark ? Color.white : Color.black.opacity(0.4), radius: 2)
//                                        })
//                                        .buttonStyle(PlainButtonStyle())
//                                }
//                                .padding(.bottom, 10)
//                                .padding(.leading, 30)
//
//                            }
//                            .padding(.top, 10)
//                        }
//                    }
//                    .padding(.top, -computedTopPadding(for: geometry.size))
//                    .opacity(1)
//
//                    ZStack {
//                        Rectangle()
//                            .foregroundColor(Color.gray.opacity(0.1))
//                        VStack {
//                            FieldsList(for: geometry.size)
//                        }
//                        .padding(.top, -20)
//                    }
//                    .cornerRadius(25, corners: [.topLeft, .topRight])
//                }
//            }
//            .edgesIgnoringSafeArea(.top)
//
//        }
//        .navigationBarTitle("")
//                .navigationBarHidden(true)
//    }
//}

//HStack {
//    HStack {
//        Image(systemName: "magnifyingglass").imageScale(.large)
//
//        TextField("Название Поля", text: $searchText, onEditingChanged: { isEditing in
//            self.showCancelButton = true
//        }, onCommit: {
//            print("onCommit")
//        }).foregroundColor(.primary)
//
//        Button(action: {
//            self.searchText = ""
//        }) {
//            Image(systemName: "xmark.circle.fill").opacity(searchText == "" ? 0 : 1)
//        }
//    }
//        .padding(EdgeInsets(top: 8, leading: 6, bottom: 8, trailing: 6))
//        .foregroundColor(.secondary)
//        .background(Color(.secondarySystemBackground))
//        .cornerRadius(10.0)
//
//    if showCancelButton  {
//        Button("Cancel") {
//            UIApplication.shared.endEditing(true) // this must be placed before the other commands here
//                self.searchText = ""
//                self.showCancelButton = false
//        }
//            .foregroundColor(Color(.systemBlue))
//    }
//}
//    .padding()
//    .navigationBarHidden(showCancelButton)


//ScrollView(.horizontal, showsIndicators: false) {
//    HStack(spacing: 10) {
//        ForEach(0..<7) { index in
//            Image("ad")
//                .resizable()
//                .aspectRatio(contentMode: .fill)
//                .frame(width: geometry.size.width / 3, height: 120)
//                .animation(.easeInOut)
//                .clipShape(RoundedRectangle(cornerRadius: 15))
//                .shadow(radius: 4)
//                .clipped()
//        }
//    }
//    .padding()
//}

//                                    VStack(spacing: 0) {
//                                        ForEach(0..<7) { index in
//                                            NavigationLink(destination: DetailView()) {
//                                                ZStack(alignment: .bottom) {
//                                                    Image("arena")
//                                                        .resizable()
//                                                        .scaledToFill()
//                                                    HStack {
//                                                        Text("СТО футбольное поле")
//                                                            .font(.system(.headline))
//                                                        Spacer()
//                                                        Text("10000 тг./час")
//                                                            .font(.system(.caption))
//                                                            .foregroundColor(.secondary)
//                                                    }
//                                                    .padding()
//                                                    .background(Color.white)
//
//                                                }
//                                                .frame(width: geometry.size.width * 0.9, height: 200)
//                                                .cornerRadius(10)
//                                                .padding(.top)
//                                            }
//                                        }
//                                    }

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
