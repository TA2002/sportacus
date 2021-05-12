//
//  FieldsList.swift
//  SportsBooking
//
//  Created by Tarlan Askaruly on 11.05.2021.
//

import SwiftUI

struct FieldsList: View {
    @State var isPresented: Bool = false
    
    var size: CGSize
    
    init(for size: CGSize) {
        self.size = size
    }
    
    var body: some View {
        VStack{
            HStack {
                Text("Наш выбор")
                    .bold()
                    .multilineTextAlignment(.trailing)
                    .padding(.leading, 20)
                
                Spacer()
                Text("Посмотреть все >")
                    .multilineTextAlignment(.leading)
                    .foregroundColor(Color(#colorLiteral(red: 0.9580881, green: 0.10593573, blue: 0.3403331637, alpha: 1)))
                    .padding(.trailing, 20)
            }
            
            
            // Card View
            VStack(spacing: 100) {
                ForEach(0..<7){i in
                    GeometryReader{g in
                        NavigationLink(destination: DetailsScreen(for: size)) {
                            VStack {
                                FieldsListCell()
                            }
                        }
                    }
                    // going to increase height based on expand...
                    .frame(height: 250)
                    .simultaneousGesture(DragGesture(minimumDistance: 800).onChanged({ (_) in
                        
                        print("dragging")
                    }))
                }
                
                
            }
            
        }
        .padding(.top, 50)
        .padding(.bottom, 150)
    }
}
