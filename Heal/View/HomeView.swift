//
//  HomeView.swift
//  Heal
//
//  Created by Yousuf Abdelfattah on 22/05/2024.
//

import SwiftUI

struct HomeView: View {
    @State var showMenu = false
    @State var selectedTab : Tab = .Dashboard
    @EnvironmentObject var manager: HealthManager
    @EnvironmentObject var authViewModel : AuthViewModel
    var body: some View {
        
        ZStack(alignment: .topLeading) {
            
            
            NavigationStack {
                VStack {
                    
                    TabView(selection: $selectedTab) {
                        DashboardView()
                            .tag(Tab.Dashboard)
                            .padding(.top, 60)
                            .environmentObject(manager)
                        ProfileView()
                            .tag(Tab.Profile)
//                            .padding(100)
    //                    RewardsView()
    //                        .tag(Tab.Rewards)
                    }
                    .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                }
            }
            .navigationBarBackButtonHidden(true)
            
            SideMenuView(showMenu: $showMenu, selectedTab: $selectedTab)
            
            HStack(alignment: .top) {
                Spacer()
                Button {
                    
                } label: {
                    Image(systemName: "bell.fill")
                        .tint(.primary)
                        .bold()
                        .font(.title)
                        .padding()
                }
                .buttonStyle(.plain)

            }
            
        }
        .onTapGesture {
            if showMenu {
                withAnimation {
                    showMenu = false
                }
            }
           
        }
        
        
    }
}

#Preview {
    HomeView()
}
