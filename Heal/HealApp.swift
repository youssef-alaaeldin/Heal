//
//  HealApp.swift
//  Heal
//
//  Created by Yousuf Abdelfattah on 17/05/2024.
//

import SwiftUI

@main
struct HealApp: App {
    @StateObject var manager = HealthManager()
    var body: some Scene {
        WindowGroup {
//            ContentView()
//            RegisterView()
           CoordinatorView()
                .environmentObject(manager)
        }
    }
}
