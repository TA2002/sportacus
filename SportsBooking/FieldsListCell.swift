//
//  FieldsListCell.swift
//  SportsBooking
//
//  Created by Tarlan Askaruly on 11.05.2021.
//

import SwiftUI

struct FieldsListCell: View {
    
    var body: some View {
        VStack {
            ZStack {
                Image("arena")
                    .resizable()
                    .frame(width: UIScreen.main.bounds.width*0.9 , height: UIScreen.main.bounds.height*0.25 )
                    .cornerRadius(20)
                    .shadow(radius: 10)
            }.edgesIgnoringSafeArea(.top)
            HStack {
                Text("Astana Arena")
                    .bold()
                    .padding(.all, 10)
                Spacer()
            }
            .padding(.leading, 20)
            
            HStack {
                Text("Alikhan Bokeikhan 2")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .padding(.leading, 30)
                Spacer()
            }
            
            HStack {
                ForEach(0 ..< 4) { item in
                    Image(systemName: "star.fill")
                        .foregroundColor(.yellow)
                        .font(.subheadline)
                }
                Spacer()
                
                Text("10000 KZT")
                    .font(.subheadline)
                    .bold()
            }
            .padding(.bottom, 30)
            .padding(.leading, 10)
            .padding(.trailing, 10)
            .padding(.leading, 20)
            .padding(.trailing, 20)
            
        }
    }
}


struct FieldsListCell_Previews: PreviewProvider {
    static var previews: some View {
        FieldsListCell()
    }
}
