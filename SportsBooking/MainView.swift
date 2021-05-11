//
//  MainView.swift
//  SportsBooking
//
//  Created by Tarlan Askaruly on 11.05.2021.
//

import SwiftUI

struct MainView: View {
    
    @State var searchText: String = ""
    @State private var showCancelButton: Bool = false
    @State private var specialOffers: [String] = ["СТО футбол", "Astana Arena", "Manchester United"]
    
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                ScrollView(showsIndicators: false) {
                    VStack{
                        SearchBar()
                        VStack {
                            HStack {
                                Text("Горячие предложения")
                                    .bold()
                                    .multilineTextAlignment(.trailing)
                                    .foregroundColor(Color(#colorLiteral(red: 0.9580881, green: 0.10593573, blue: 0.3403331637, alpha: 1)))
                                    .padding(.leading, 20)
                                
                                Spacer()
                                Text("Посмотреть все >")
                                    .multilineTextAlignment(.leading)
                                    .foregroundColor(Color(#colorLiteral(red: 0.9580881, green: 0.10593573, blue: 0.3403331637, alpha: 1)))
                                    .font(.subheadline)
                                    .padding(.trailing, 20)
                            }
                            
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack {
                                    ForEach(0..<7) { card in
                                        NavigationLink(
                                            destination: DetailView(),
                                            label: {
                                                SpecialOfferCarousel()
                                                    .background(Color.white.opacity(1))
                                                    .cornerRadius(15)
                                                    .shadow(radius: 1)
                                            })
                                            .buttonStyle(PlainButtonStyle())
                                    }
                                    .padding(.bottom, 10)
                                    .padding(.leading, 30)
                                    
                                }
                            }
                        }
                        .padding(.top, -50)
                        .opacity(1)
                        
                        ZStack {
                            Rectangle()
                                .foregroundColor(Color.gray.opacity(0.1))
                            VStack {
                                FieldsList()
                            }
                            .padding(.top, -20)
                        }
                        .cornerRadius(25, corners: [.topLeft, .topRight])
                    }
                }
                .edgesIgnoringSafeArea(.top)
                
            }
            .navigationBarTitle("")
                    .navigationBarHidden(true)
        }
    }
}

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
