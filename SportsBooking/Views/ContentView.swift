//
//  ContentView.swift
//  SportsBooking
//
//  Created by Tarlan Askaruly on 10.05.2021.
//

import SwiftUI
import UIKit
import Firebase

struct ContentView: View {
    @ObservedObject var userSession = UserSession()
    //@Environment(\.colorScheme) var colorScheme
    init() {
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        UINavigationBar.appearance().shadowImage = UIImage()
        UINavigationBar.appearance().isTranslucent = true
        UINavigationBar.appearance().tintColor = .clear
        UINavigationBar.appearance().backgroundColor = .clear
        
        UITabBar.appearance().backgroundColor = .white
        
    }
    var body: some View {
            
        Group {
            if userSession.userLogedIn {
                TabView {
                    HomeScreen(userSession: userSession)
                        .tabItem {
                            Label("Главная", systemImage: "house.fill")
                        }
                        .tag(0)
                    ProfileScreen(currentUserSession: userSession)
                        .tabItem {
                            Label("Профиль", systemImage: "person.circle.fill")
                        }
                        .tag(1)
                }
                .accentColor(.red)
            }
            else {
                LoginView(currentUserSession: userSession)
            }
        }
        
        
    }
}

struct ProfileScreen: View {
    
    @ObservedObject var currentUserSession: UserSession
    
    var body: some View {
        Button("Log out", action: {
            currentUserSession.userDidLogOut()
        })
    }
    
    
    
}





//extension UINavigationBar {
//    static func changeAppearance(clear: Bool) {
//        let appearance = UINavigationBarAppearance()
//        
//        if clear {
//            appearance.configureWithTransparentBackground()
//        } else {
//            appearance.configureWithDefaultBackground()
//        }
//        
//        UINavigationBar.appearance().standardAppearance = appearance
//        UINavigationBar.appearance().compactAppearance = appearance
//        UINavigationBar.appearance().scrollEdgeAppearance = appearance
//    }
//}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
}

struct RoundedCorner: Shape {

    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

extension UIApplication {
    func endEditing(_ force: Bool) {
        self.windows
            .filter{$0.isKeyWindow}
            .first?
            .endEditing(force)
    }
}

struct ResignKeyboardOnDragGesture: ViewModifier {
    var gesture = DragGesture().onChanged{_ in
        UIApplication.shared.endEditing(true)
    }
    func body(content: Content) -> some View {
        content.gesture(gesture)
    }
}

extension View {
    func resignKeyboardOnDragGesture() -> some View {
        return modifier(ResignKeyboardOnDragGesture())
    }
}
