//
//  DetailView.swift
//  DetailsScreen
//
//  Created by Tarlan Askaruly on 11.05.2021.
//

import SwiftUI
import Tagly

struct DetailsScreen: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State private var isFavorite: Bool = false
    
    private var size: CGSize
    
//    private var tags = [
//        Tag(id: 1, title: "Душ"),
//        Tag(id: 2, title: "Искусственная трава"),
//        Tag(id: 3, title: "Телевизор"),
//        Tag(id: 4, title: "Раздевалка")
//    ]
    
    private var tags = ["Душ", "Искусственная трава", "Телевизор", "Раздевалка"]
    
    init(for size: CGSize) {
        UINavigationBar.appearance().tintColor = UIColor.white
        self.size = size
        //print(300 / size.width)
        //UINavigationBar.appearance().color
    }
    
    private func computedImageHeight(for size: CGSize) -> CGFloat {
        size.width * 0.725
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
                    ZStack(alignment: .topTrailing) {
                        Image("court")
                            .resizable()
                            .scaledToFill()
                            .frame(width: geometry.size.width, height: computedImageHeight(for: size))
                            //.clipShape(MyRectangularShape(corner: .topLeft, radii: geometry.size.width / 6))
                            .shadow(color: Color.gray, radius: 20)
                            .opacity(0.9)
                            .cornerRadius(5)
                        
//                        .padding(.top, 55)
//                        .padding(.trailing, 20)
                    }
                    .edgesIgnoringSafeArea(.all)
                    //.padding(.top, 40)
                         
                    ZStack {
                        RoundedRectangle(cornerRadius: 40)
                            .fill(Color(#colorLiteral(red: 0.9580881, green: 0.10593573, blue: 0.3403331637, alpha: 1)))
                            .frame(height: 50)
                            .padding(.horizontal, 30)
                            //.shadow(color: Color.gray, radius: 20)
                        Text("БРОНИРОВАТЬ")
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                    }.padding(.top, -30)
                    
                    HStack {
                        Text("Astana Arena")
                            .font(.title)
                            .bold()
                            .multilineTextAlignment(.leading)
                            .padding(.horizontal)
                        Spacer()
                    }
                    .padding(.top, 5)
                    HStack {
                        //Image(systemName: "mappin.and.ellipse").imageScale(.large).foregroundColor(Color(#colorLiteral(red: 0.9580881, green: 0.10593573, blue: 0.3403331637, alpha: 1)))
                        Image("pin")
                            .renderingMode(.template)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 25, height: 25)
                            .foregroundColor(Color(#colorLiteral(red: 0.9580881, green: 0.10593573, blue: 0.3403331637, alpha: 1)))
                        Text("Бокейхана 2").font(.subheadline).bold()
                        Spacer()
                        Image(systemName: "star.fill")
                            .foregroundColor(Color(#colorLiteral(red: 0.9580881, green: 0.10593573, blue: 0.3403331637, alpha: 1)))
                            .font(.subheadline)
                        Text("4.5 ").bold() + Text("(298)").foregroundColor(.secondary)
                    }
                    .padding(.top, 5)
                    .padding(.horizontal)
                    
                    HStack {
                        Text("Детали").font(.title3).padding(.horizontal).padding(.top)
                        Spacer()
                    }
                    Divider()
                    TagCloudView(data: tags, spacing: 8) { tag in
                        Text(tag)
                            .foregroundColor(Color.white)
                            .padding(.horizontal, 10)
                            .padding(.vertical, 5)
                            .background(Color(#colorLiteral(red: 0.9580881, green: 0.10593573, blue: 0.3403331637, alpha: 1)))
                            .cornerRadius(5)
                    }
                    .padding(.horizontal)
                    Spacer(minLength: 100)
                    
                }
            }
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(
                leading: ZStack(alignment: .center) {
                    Circle()
                        .fill(Color.white)
                        .frame(width: 40, height: 40)
                        .shadow(color: Color.gray, radius: 5)
                    Image(systemName: "arrow.left")
                        .imageScale(.large)
                        .foregroundColor(Color(#colorLiteral(red: 0.9580881, green: 0.10593573, blue: 0.3403331637, alpha: 1)))
                }.onTapGesture {
                    presentationMode.wrappedValue.dismiss()
                },
                trailing: ZStack(alignment: .center) {
                    Circle()
                        .fill(Color.white)
                        .frame(width: 40, height: 40)
                        .shadow(color: Color.gray, radius: 5)
                    Image(systemName: isFavorite ? "heart.fill" : "heart")
                        .imageScale(.large)
                        .foregroundColor(Color(#colorLiteral(red: 0.9580881, green: 0.10593573, blue: 0.3403331637, alpha: 1)))
                }.onTapGesture {
                    isFavorite = !isFavorite
                }
            )
        }
        .edgesIgnoringSafeArea(.all)
        .onAppear{
        }
    }
    
}

extension String: Identifiable {
    public var id: String {
        self
    }
}


//                            Button(action: {
//
//                                            }){
//                                                HStack{
//                                                    Spacer()
//                                                    Text("BOOK NOW")
//                                                        .fontWeight(.bold)
//                                                        .foregroundColor(.white)
//
//                                                    Spacer()
//                                                }
//                                            }
//                                            .padding()
//                                            .background(Color("))
//                                            .buttonStyle(PlainButtonStyle())
//                                            .clipShape(RoundedRectangle(cornerRadius: 40))
//                            .padding(.horizontal, 30)
//                            Circle()
//                                .fill(Color.white)
//                                .frame(width: 75, height: 75)
//                                .offset(x: 0, y: 30)
//                                .shadow(color: Color.gray, radius: 20)
//
//                            Image(systemName: "play.fill")
//                                .resizable()
//                                .frame(width: 25, height: 25)
//                                .foregroundColor(Color("DarkRed"))
//                                .offset(x: 2, y: 32)
