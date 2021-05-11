//
//  FieldsList.swift
//  SportsBooking
//
//  Created by Tarlan Askaruly on 11.05.2021.
//

import SwiftUI

struct FieldsList: View {
    @State var isPresented: Bool = false
    
    var body: some View {
        VStack{
            HStack {
                Text("Our picks")
                    .bold()
                    .multilineTextAlignment(.trailing)
                    .padding(.leading, 20)
                
                Spacer()
                Text("View all >")
                    .multilineTextAlignment(.leading)
                    .foregroundColor(Color(#colorLiteral(red: 0.9580881, green: 0.10593573, blue: 0.3403331637, alpha: 1)))
                    .padding(.trailing, 20)
            }
            
            
            // Card View
            VStack(spacing: 100) {
                ForEach(0..<7){i in
                    GeometryReader{g in
                        NavigationLink(destination: DetailView()) {
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

struct FieldsList_Previews: PreviewProvider {
    static var previews: some View {
        FieldsList()
    }
}
