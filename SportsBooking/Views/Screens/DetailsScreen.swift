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
    
    @ObservedObject var userSession: UserSession = UserSession()
    
    @State private var isFavorite: Bool = false
    @State var sheetIsPresented = false
    @State var lunbo_img_index: Int = 0
    @State var show_img_detail: Bool = false
    
    var field: Field
    private var size: CGSize
    
    
    private var tags = ["Душ", "Искусственная трава", "Телевизор", "Раздевалка"]
    let images: [Image] = [Image("court"), Image("court"), Image("court")]
    
    init(field: Field, for size: CGSize) {
        UINavigationBar.appearance().tintColor = UIColor.white
        self.size = size
        self.field = field
        //print(300 / size.width)
        //UINavigationBar.appearance().color
    }
    @State private var buttonIndex = 0
    private var numberOfFields = 1
    
    var body: some View {
        return GeometryReader { geometry in
            ZStack(alignment: .bottom) {
                Color.white
                VStack {
                    ScrollView(.vertical) {
                        VStack {
                            ZStack {
                                LunBo(images: images, height: computedImageHeight(for: size), index: $lunbo_img_index)
                                    .onTapGesture {
                                        show_img_detail = true
                                    }
                                        
                                        if show_img_detail {
                                            ImageDetail(images: images, now_index: $lunbo_img_index)
                                                .onTapGesture {
                                                    show_img_detail = false
                                                }
                                        }
                            }
                            .edgesIgnoringSafeArea(.all)
                            
                            HStack {
                                Text(field.name)
                                    .font(.system(size: nameFontSize, weight: .heavy, design: .default))
                                    .foregroundColor(blackColor)
                                Spacer()
                            }
                                .padding()
                            
                            HStack {
                                Image("star")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: reviewsFontSize, height: reviewsFontSize)
                                    .clipped()
                                Text("4.5 (290 отзывов) ・ Алихана Бокейхана 2 ")
                                    .font(.system(size: reviewsFontSize, weight: .regular, design: .default)).foregroundColor(.secondary)
                                    .foregroundColor(grayColor)
                                Spacer()
                                
                            }
                                .padding(.horizontal)
                                .padding(.top, -15)
                            
                            Divider().border(Color.gray, width: 5).padding()
                            
                            Group {
                                if numberOfFields > 1 {
                                    HStack() {
                                        Spacer()
                                        ForEach(0..<numberOfFields){ index in
                                            Button(action: {
                                                buttonIndex = index
                                            }, label: {
                                                Text("Поле #\(index + 1)")
                                                    .padding(.vertical, 10)
                                                    .padding(.horizontal)
                                                    .font(.system(size: customSize, weight: .semibold, design: .default))
                                                    .foregroundColor(index == buttonIndex ? Color.white : Color.black)
                                            })
                                            .background(index == buttonIndex ? filterOrangeColor : bgHexColor)
                                            .cornerRadius(10)
                                            Group(){
                                                if index != numberOfFields - 1 {
                                                    Spacer()
                                                }
                                            }
                                        }
                                        Spacer()
                                    }
                                    .padding(.horizontal)
                                    .padding(.top, -10)
                                }
                                
                            }
                            
                            Text("50×50 ・ Крытое ・ Искусственная трава")
                                .font(.system(size: customSize, weight: .semibold, design: .default))
                                .foregroundColor(blackColor)
                                .padding(.horizontal)
                                .padding(.top, 10)
                            
                            HStack {
                                Text("Условия")
                                    .font(.system(size: customTitleSize, weight: .bold, design: .default)).foregroundColor(blackColor)
                                Spacer()
                            }
                                .padding(.horizontal)
                                .padding(.top, 15)
                            
                            
                            TagCloudView(data: tags, spacing: 10) { tag in
                                Text(tag)
                                    .font(.system(size: customSize, weight: .light, design: .default))
                                    //.font(.system(size: reviewsFontSize, weight: .regular, design: .default))
                                    .foregroundColor(Color.white)
                                    .padding(.horizontal, 10)
                                    .padding(.vertical, 5)
                                    .background(filterOrangeColor)
                                    .cornerRadius(5)
                            }
                                .padding(.horizontal)
                            
                            HStack {
                                Text("График работа")
                                    .font(.system(size: customTitleSize, weight: .bold, design: .default)).foregroundColor(blackColor)
                                Spacer()
                            }
                                .padding(.horizontal)
                                .padding(.vertical, 5)
                            
                            
                            WorkTimeView()
                                .padding(.vertical, 5)
                                .padding(.horizontal)
                            
                            //.padding(.top, 40)
                        }
                    }
                    .layoutPriority(1)
                    ZStack(alignment: .center) {
                        Rectangle()
                            .fill(bgHexColor)
                            
                        HStack {
                            Spacer()
                            HStack {
                                Text("10.000₸")
                                    .font(.system(size: priceFontSize, weight: .heavy, design: .default))
                                    .foregroundColor(blackColor)
                                Text("/ час")
                                    .font(.system(size: priceFontSize * 0.85, weight: .bold, design: .default)).foregroundColor(.secondary).padding(.leading, -4)
                                    .foregroundColor(hourGrayColor)
                            }
                            .padding()
                            Spacer()
                            Button(action: {
                                
                            }, label: {
                                Text("Забронировать")
                                    .bold()
                                    .foregroundColor(.white)
                            })
                            .padding()
                            .frame(width: geometry.size.width * 0.5)
                            .background(filterOrangeColor)
                            .cornerRadius(8)
                            .padding(.vertical)
                            Spacer()
                        }
                        
                    }
                }
            }
            .sheet(isPresented: $sheetIsPresented) {
                    BookingScreen()
            }
        }
        .edgesIgnoringSafeArea([.top, .horizontal])
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(
            leading: ZStack(alignment: .center) {
                Circle()
                    .fill(Color.black.opacity(0.2))
                    .frame(width: 40, height: 40)
                    .shadow(color: Color.gray, radius: 5)
                Image(systemName: "arrow.left")
                    .imageScale(.large)
                    .foregroundColor(Color.white)
            }.onTapGesture {
                presentationMode.wrappedValue.dismiss()
            },
            trailing: ZStack(alignment: .center) {
                Circle()
                    .fill(Color.black.opacity(0.2))
                    .frame(width: 40, height: 40)
                    .shadow(color: Color.gray, radius: 5)
                Image(systemName: isFavorite ? "heart.fill" : "heart")
                    .imageScale(.large)
                    .foregroundColor(.white)
                //Color(#colorLiteral(red: 0.9580881, green: 0.10593573, blue: 0.3403331637, alpha: 1)
                }.onTapGesture {
                    isFavorite = !isFavorite
                }
            )
    }
    
    // MARK: -Drawing Constants
    
    //private var
    
    private var imageWidth: CGFloat {
        UIScreen.main.bounds.width
    }
    
    private var reviewsFontSize: CGFloat {
        max((UIScreen.main.bounds.height) / 65, 13)
    }
    
    private func computedImageHeight(for size: CGSize) -> CGFloat {
        size.width * 0.6//0.725
    }
    
    private var priceFontSize: CGFloat {
        (UIScreen.main.bounds.height) / 45
    }
    
    private var nameFontSize: CGFloat {
        UIScreen.main.bounds.height / 30
    }
    
    private var customTitleSize: CGFloat {
        max(UIScreen.main.bounds.height / 37, 18)
    }
    
    private var customSize: CGFloat {
        max((UIScreen.main.bounds.height) / 50, 15)
    }
    
}



extension String: Identifiable {
    public var id: String {
        self
    }
}


//private let nameFontSize = (UIScreen.main.bounds.height * 8) / 230
//private let attributesFontSize = (UIScreen.main.bounds.height * 8) / 400
//private let orderButtonFontSize = (UIScreen.main.bounds.height * 8) / 350

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

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }

        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}

//ZStack {
//    RoundedRectangle(cornerRadius: 40)
//        .fill(Color(#colorLiteral(red: 0.9580881, green: 0.10593573, blue: 0.3403331637, alpha: 1)))
//        .frame(height: 50)
//        .padding(.horizontal, 30)
//        //.shadow(color: Color.gray, radius: 20)
//    Text("БРОНИРОВАТЬ")
//        .font(.system(size: orderButtonFontSize, weight: .bold, design: .default))
//        .foregroundColor(.white)
//}.onTapGesture {
//    sheetIsPresented = true
//}
//
//HStack {
//    Text("Astana Arena")
//        .font(.system(size: nameFontSize, weight: .bold, design: .default))
//        //.font(.title)
//        //.bold()
//        .multilineTextAlignment(.leading)
//        .padding(.horizontal)
//    Spacer()
//}
//.padding(.top, 5)
//HStack {
//    Image("pin")
//        .renderingMode(.template)
//        .resizable()
//        .scaledToFill()
//        .frame(width: 25, height: 25)
//        .foregroundColor(Color(#colorLiteral(red: 0.9580881, green: 0.10593573, blue: 0.3403331637, alpha: 1)))
//    Text("Бокейхана 2")
//        .font(.system(size: attributesFontSize, weight: .bold, design: .default))
//        //.font(.subheadline).bold()
//    Spacer()
//    Image(systemName: "star.fill")
//        .foregroundColor(Color(#colorLiteral(red: 0.9580881, green: 0.10593573, blue: 0.3403331637, alpha: 1)))
//        .font(.system(size: attributesFontSize, weight: .bold, design: .default))
//
//    Text("4.5 ")
//        .font(.system(size: attributesFontSize, weight: .bold, design: .default)) + Text("(298)")
//        .font(.system(size: attributesFontSize, weight: .bold, design: .default)).foregroundColor(.secondary)
//}
//.padding(.top, 5)
//.padding(.horizontal)
//
//HStack {
//    Text("Детали").font(.title3).padding(.horizontal).padding(.top)
//    Spacer()
//}
//Divider()
//TagCloudView(data: tags, spacing: 8) { tag in
//    Text(tag)
//        .foregroundColor(Color.white)
//        .padding(.horizontal, 10)
//        .padding(.vertical, 5)
//        .background(Color(#colorLiteral(red: 0.9580881, green: 0.10593573, blue: 0.3403331637, alpha: 1)))
//        .cornerRadius(5)
//}
//.padding(.horizontal)
//Spacer(minLength: 100)
