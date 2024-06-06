//
//  SideMenuView.swift
//  Heal
//
//  Created by Yousuf Abdelfattah on 19/05/2024.
//

import SwiftUI

enum Tab : String, CaseIterable {
    case Dashboard
    case Profile
    case Rewards
    case Logout
}

struct SideMenuView: View {
    
    
    @Binding var showMenu: Bool
    @Binding var selectedTab: Tab
    
    @EnvironmentObject var authViewModel: AuthViewModel
    @EnvironmentObject var coordinator: Coordinator
    
    @State var showAlert = false
    var body: some View {
        
        GeometryReader { geomtry in
       
        ZStack(alignment: .topLeading) {
            Color.black.opacity(showMenu ? 0.9 : 0)
                .ignoresSafeArea()
            
            HStack {
                VStack(alignment: .leading, spacing: 10) {
                    Button {
                        withAnimation {
                            showMenu.toggle()
                        }
                    } label: {
                        Image(systemName: "slider.horizontal.3")
                            .tint(.primary)
                            .bold()
                            .font(.title)
                    }
                    .buttonStyle(.plain)
                    
                    if(showMenu) {
                        ForEach(Tab.allCases, id: \.rawValue) { tab in
                            HStack {
                                AppImage.smallEclipse.image()
                                    .resizable()
                                    .frame(width: 10, height: 10)
                                    .opacity(selectedTab == tab ? 1 : 0)
                                
                                Text(tab.rawValue)
                                    .font(.system(size: 20))
                                    .foregroundStyle(.primary)
                                    .onTapGesture {
                                        withAnimation {
                                            selectedTab = tab
                                        }
                                        if tab == .Logout {
                                            showAlert = true
                                            
                                        }
                                        
                                    }
                                    
                            }
                        }
                    }
                    

                }
                .padding()
//                Spacer()
                
            }
            .background(
                showMenu ? LinearGradient(colors: [Colors.startColor.color(), Colors.endColor.color()], startPoint: .topLeading, endPoint: .bottomTrailing)
                : nil
//                Colors.startColor.color()
            )
            .clipShape(.rect(cornerRadius: 15))
            
            
            }
        }
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text("Confirm Logout"),
                message: Text("Are you sure you want to log out?"),
                primaryButton: .destructive(Text("Logout")) {
                    authViewModel.signOut()
                    coordinator.dismissFullScreen()
                },
                secondaryButton: .cancel()
            )
        }
        
        
    }
    
        
        
}

#Preview {
    SideMenuView(showMenu: .constant(true), selectedTab: .constant(.Dashboard))
}
