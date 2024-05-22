//
//  Coordinator.swift
//  Heal
//
//  Created by Yousuf Abdelfattah on 19/05/2024.
//

import SwiftUI

enum Page: String, Identifiable {
    
    case profile, rewards, dashboard, register
    
    var id: String {
        self.rawValue
    }
}



enum FullScreenCover: String, Identifiable {
    
    case home
    
    var id: String {
        self.rawValue
    }
}

class Coordinator: ObservableObject {
    
    @Published var path = NavigationPath()
    @Published var fullScreenCover : FullScreenCover?
    
    
    func push(_ page: Page) {
        path.append(page)
    }
    
    func present(fullScreenCover: FullScreenCover) {
        self.fullScreenCover = fullScreenCover
    }
    
    func pop() {
        path.removeLast()
    }
    
    func popToRoot() {
        path.removeLast(path.count)
    }
    
    func dismissFullScreen() {
        self.fullScreenCover = nil
        
    }
    
    @ViewBuilder
    func build(page: Page) -> some View {
        switch page {
        case .register:
            RegisterView()
        case .profile:
            DashboardView()
        case .rewards:
            DashboardView()
        case .dashboard:
            DashboardView()
        }
    }
    
    @ViewBuilder
    func build(fullScreenCover: FullScreenCover) -> some View {
        switch fullScreenCover {
        case .home:
            HomeView()
        }
    }
}
