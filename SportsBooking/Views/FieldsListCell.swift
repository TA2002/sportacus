//
//  FieldsListCell.swift
//  SportsBooking
//
//  Created by Tarlan Askaruly on 11.05.2021.
//

import SwiftUI

struct Field {
    var name: String
    var address: String
    var pricePerHour: Int
    //var pitches: [Pitch]
    
    var voteRating: Float
    var numberOfVotes: Int
    
    var isFavorite: Bool
    
    init(name: String, address: String, pricePerHour: Int, voteRating: Float, numberOfVotes: Int, isFavorite: Bool) {
        self.name = name
        self.address = address
        self.pricePerHour = pricePerHour
        self.voteRating = voteRating
        self.numberOfVotes = numberOfVotes
        self.isFavorite = isFavorite
    }
    
}

struct Pitch {
    var type: String
    var floorMaterial: String
    var heightInMeters: Int
    var widthInMeters: Int
    var conveniences: [String]
    var pricePerHour: Int
}


struct FieldsListCell: View {
    @Environment(\.colorScheme) var colorScheme
    @ObservedObject var userSession: UserSession
    
    var size: CGSize
    var field: Field
    
    init(field: Field, size: CGSize, userSession: UserSession) {
        self.size = size
        self.field = field
        self.userSession = userSession
    }
    
    private var cellImageWidth: CGFloat {
        UIScreen.main.bounds.width*0.9
    }
    
    private var nameFontSize: CGFloat {
        (UIScreen.main.bounds.height) / 50
    }
    
    private var reviewsFontSize: CGFloat {
        (UIScreen.main.bounds.height) / 65
    }
    
    private var priceFontSize: CGFloat {
        (UIScreen.main.bounds.height) / 45
    }
    
    
    var body: some View {
        NavigationLink(destination: DetailsScreen(field: field, for: size)) {
            ZStack(alignment: .bottom) {
                Image("court")
                    .resizable()
                    .scaledToFill()
                    .frame(width: cellImageWidth , height: cellImageWidth * 0.45 )
                    .cornerRadius(10, corners: [.topLeft, .topRight])
                    .clipped()
                
                ZStack(alignment: .center) {
                    Circle()
                        .fill(Color.black.opacity(0.2))
                        .frame(width: 40, height: 40)
                        .shadow(color: Color.gray, radius: 5)
                    Image(systemName: field.isFavorite ? "heart.fill" : "heart")
                        .imageScale(.large)
                        .foregroundColor(Color.white)
                }.offset(x: cellImageWidth / 2.4, y: -cellImageWidth * 0.3)
                .onTapGesture {
                    //field.isFavorite = !field.isFavorite
                }
                ZStack {
                    Rectangle()
                        .fill(colorScheme == .dark ? Color.black : Color.white)
                        .cornerRadius(10, corners: [.bottomRight, .bottomLeft])
                        .frame(width: cellImageWidth , height: cellImageWidth * 0.3)
                    VStack {
                        HStack {
                            Text("Football Life")
                                .font(.system(size: nameFontSize, weight: .semibold, design: .default))
                                .foregroundColor(blackColor)
                            Spacer()
                        }
                        HStack {
                            Text("Алихана Бокейхана 2")
                                .font(.system(size: reviewsFontSize, weight: .regular, design: .default))
                                .foregroundColor(grayColor)
                            Spacer()
                            Image("star")
                                .resizable()
                                .scaledToFit()
                                .frame(width: reviewsFontSize, height: reviewsFontSize)
                                .clipped()
                            Text("4.5")
                                .font(.system(size: reviewsFontSize, weight: .regular, design: .default))
                                .foregroundColor(blackColor)
                            Text("(290)")
                                .font(.system(size: reviewsFontSize, weight: .regular, design: .default)).foregroundColor(.secondary)
                                .foregroundColor(grayColor)
                        }
                            .padding(.top, -5)
                        HStack {
                            Text("10.000₸")
                                .font(.system(size: priceFontSize, weight: .heavy, design: .default))
                                .foregroundColor(blackColor)
                            Text("/ час")
                                .font(.system(size: priceFontSize * 0.85, weight: .bold, design: .default)).foregroundColor(.secondary).padding(.leading, -4)
                                .foregroundColor(hourGrayColor)
                            Spacer()
                        }
                        
                    }
                    .padding(.horizontal)
                        
                }.offset(x: 0, y: cellImageWidth * 0.28)
            }
                .shadow(color: colorScheme == .dark ? Color.white.opacity(0.2) : Color.black.opacity(0.2), radius: 20, x: 3, y: 3)
        }
    }
}
    
