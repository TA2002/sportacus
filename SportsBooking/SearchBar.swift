//
//  SearchBar.swift
//  SportsBooking
//
//  Created by Tarlan Askaruly on 11.05.2021.
//

import SwiftUI

struct SearchBar: View {
    @State var search = ""
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.9580881, green: 0.10593573, blue: 0.3403331637, alpha: 1)), Color(#colorLiteral(red: 0.9843164086, green: 0.9843164086, blue: 0.9843164086, alpha: 1))]), startPoint: .top, endPoint: .bottom)
                .frame(width: UIScreen.main.bounds.width, height: (UIScreen.main.bounds.height)*0.25, alignment: .center)
                .edgesIgnoringSafeArea(.all)
            
            
            VStack {
                HStack {
                    Text("Главная")
                        .bold()
                        .font(.title)
                        .multilineTextAlignment(.trailing)
                        .foregroundColor(.white)
                        .padding(.leading, 20)
                        //.padding(.top, -40)
                    Spacer()
                    HStack {
                        Text("Нур-Султан")
                            .font(.headline)
                            .multilineTextAlignment(.leading)
                            .foregroundColor(.white)
                        Image(systemName: "mappin.and.ellipse")
                            .foregroundColor(Color.white)
                            .imageScale(.large)
                            .padding(.trailing, 20)
                    }.onTapGesture {
                        
                    }
                    
                }
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.gray)
                        .font(.title)
                    TextField("Название помещения...", text: $search)
                        .font(.title3)
                }
                .frame(width:  ( UIScreen.main.bounds.width)*0.85, height: 40, alignment: .leading)
                .padding(.leading, 20)
                .background(Color.white)
                .cornerRadius(10)
                
            }
        }
    }
}


struct SearchBar_Previews: PreviewProvider {
    static var previews: some View {
        SearchBar()
    }
}
