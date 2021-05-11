//
//  UserSession.swift
//  SportsBooking
//
//  Created by Tarlan Askaruly on 12.05.2021.
//

import Foundation
import SwiftUI
import Firebase

class UserSession: ObservableObject {
    @Published var userLogedIn: Bool = false
    
    init() {
        userLogedIn = isUserLoggedIn()
    }
    
    func userDidLogIn() {
        userLogedIn = true
        //UserDefaults.standard.set(true, forKey: "userLogedIn")
        print(Auth.auth().currentUser?.email ?? "")
    }
    
    func userDidLogOut() {
        do {
            try Auth.auth().signOut()
            userLogedIn = false
            print("userLogenIn: \(userLogedIn)")
        } catch {
          print("Sign out error")
        }
    }
    
    func isUserLoggedIn() -> Bool {
      return Auth.auth().currentUser != nil
    }
    
}
