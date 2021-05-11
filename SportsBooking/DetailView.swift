//
//  DetailView.swift
//  SportsBooking
//
//  Created by Tarlan Askaruly on 11.05.2021.
//

import SwiftUI

struct DetailView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    init() {
        UINavigationBar.appearance().tintColor = UIColor.white
        //UINavigationBar.appearance().color
    }
    
    struct MyRectangularShape: Shape {
        
        var corner : UIRectCorner
        var radii : CGFloat
        func path(in rect: CGRect) -> Path {
            let path = UIBezierPath(roundedRect: rect, byRoundingCorners: [.bottomLeft, .bottomRight], cornerRadii: CGSize(width: radii, height: radii))

            return Path(path.cgPath)
        }
    }
    
    var body: some View {
        return GeometryReader { geometry in
            ScrollView(.vertical) {
                VStack {
                    ZStack(alignment: .bottom) {
                        Image("court")
                            .resizable()
                            .scaledToFill()
                            .frame(width: geometry.size.width, height: 300)
                            .clipShape(MyRectangularShape(corner: .topLeft, radii: geometry.size.width / 6))
                            .shadow(color: Color.gray, radius: 20)
                            .opacity(0.9)
                        ZStack(alignment: .center) {
                            Circle()
                                .fill(Color.white)
                                .frame(width: 75, height: 75)
                                .offset(x: 0, y: 30)
                                .shadow(color: Color.gray, radius: 20)
                            
                            Image(systemName: "play.fill")
                                .resizable()
                                .frame(width: 25, height: 25)
                                .foregroundColor(Color("DarkRed"))
                                .offset(x: 2, y: 32)
                        }
                    }
                    .edgesIgnoringSafeArea(.all)
                    //.padding(.top, 40)
                    
                    Spacer()
                                        
                }
            }
        }
        .edgesIgnoringSafeArea(.all)
        .onAppear{
        }
    }
    
}
