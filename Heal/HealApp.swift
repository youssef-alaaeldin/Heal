//
//  HealApp.swift
//  Heal
//
//  Created by Yousuf Abdelfattah on 17/05/2024.
//

import SwiftUI
import Firebase

@main
struct HealApp: App {
    @StateObject var manager = HealthManager()
    @StateObject var authViewModel = AuthViewModel()
    
    init() {
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
//            ContentView()
//            RegisterView()
           CoordinatorView()
                .environmentObject(manager)
                .environmentObject(authViewModel)
        }
    }
}
