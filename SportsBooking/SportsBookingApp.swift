//
//  SportsBookingApp.swift
//  SportsBooking
//
//  Created by Tarlan Askaruly on 10.05.2021.
//

import SwiftUI
import Firebase

@main
struct SportsBookingApp: App {
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
