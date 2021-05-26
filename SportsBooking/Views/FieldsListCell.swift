//
//  FieldsListCell.swift
//  SportsBooking
//
//  Created by Tarlan Askaruly on 11.05.2021.
//

import SwiftUI

struct FieldsListCell: View {
    @Environment(\.colorScheme) var colorScheme
    @ObservedObject var userSession: UserSession
    
    var size: CGSize
    var footballFacility: FootballFacility
    
    @State var active = false
    
    init(footballFacility: FootballFacility, size: CGSize, userSession: UserSession) {
        self.size = size
        self.footballFacility = footballFacility
        self.userSession = userSession
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            RemoteImage(url: footballFacility.photoUrls[0], width: cellImageWidth, height: cellImageWidth * 0.45)
                .aspectRatio(contentMode: .fill)
//                    .resizable()
//                    .scaledToFill()
                .frame(width: cellImageWidth , height: cellImageWidth * 0.45 )
                .cornerRadius(10, corners: [.topLeft, .topRight])
                .clipped()
            
            Button(action: {
                userSession.toggleFavoriteId(footballFacilityId: footballFacility.id)
            }) {
                ZStack(alignment: .center) {
                    Circle()
                        .fill(Color.black.opacity(0.2))
                        .frame(width: 40, height: 40)
                        .shadow(color: Color.gray, radius: 5)
                    Image(systemName: userSession.profile.favoriteIds.contains(footballFacility.id) ? "heart.fill" : "heart")
                        .imageScale(.large)
                        .foregroundColor(Color.white)
                }
            }.buttonStyle(HighPriorityButtonStyle()).offset(x: cellImageWidth / 2.4, y: -cellImageWidth * 0.3)
            
            ZStack {
                Rectangle()
                    .fill(colorScheme == .dark ? Color.black : Color.white)
                    .cornerRadius(10, corners: [.bottomRight, .bottomLeft])
                    .frame(width: cellImageWidth , height: cellImageWidth * 0.3)
                VStack {
                    HStack {
                        Text(footballFacility.name)
                            .font(.system(size: nameFontSize, weight: .semibold, design: .default))
                            .foregroundColor(blackColor)
                        Spacer()
                    }
                    HStack {
                        Text(footballFacility.address)
                            .font(.system(size: reviewsFontSize, weight: .regular, design: .default))
                            .foregroundColor(grayColor)
                        Spacer()
                        Image("star")
                            .resizable()
                            .scaledToFit()
                            .frame(width: reviewsFontSize, height: reviewsFontSize)
                            .clipped()
                        Text("\(footballFacility.averageRating.clean)")
                            .font(.system(size: reviewsFontSize, weight: .regular, design: .default))
                            .foregroundColor(blackColor)
                        Text("(\(footballFacility.reviews.count) отзывов)")
                            .font(.system(size: reviewsFontSize, weight: .regular, design: .default)).foregroundColor(.secondary)
                            .foregroundColor(grayColor)
                    }
                        .padding(.top, -5)
                    HStack {
                        Text("от \(footballFacility.getMinimumPrice())₸")
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
            .padding(.bottom, cellImageWidth * 0.28)
            .shadow(color: colorScheme == .dark ? Color.white.opacity(0.2) : Color.black.opacity(0.2), radius: 20, x: 3, y: 3)
    }
    
    private var cellImageWidth: CGFloat {
        UIScreen.main.bounds.width*0.9
    }
    
    private var nameFontSize: CGFloat {
        max((UIScreen.main.bounds.height) / 50, 15)
    }
    
    private var reviewsFontSize: CGFloat {
        max((UIScreen.main.bounds.height) / 65, 13)
    }
    
    private var priceFontSize: CGFloat {
        max((UIScreen.main.bounds.height) / 45, 17)
    }
    
}

struct HighPriorityButtonStyle: PrimitiveButtonStyle {
    func makeBody(configuration: PrimitiveButtonStyle.Configuration) -> some View {
        MyButton(configuration: configuration)
    }
    
    private struct MyButton: View {
        @State var pressed = false
        let configuration: PrimitiveButtonStyle.Configuration
        
        var body: some View {
            let gesture = DragGesture(minimumDistance: 0)
                .onChanged { _ in self.pressed = true }
                .onEnded { value in
                    self.pressed = false
                    if value.translation.width < 10 && value.translation.height < 10 {
                        self.configuration.trigger()
                    }
                }
            
            return configuration.label
                .opacity(self.pressed ? 0.5 : 1.0)
                .highPriorityGesture(gesture)
        }
    }
}
