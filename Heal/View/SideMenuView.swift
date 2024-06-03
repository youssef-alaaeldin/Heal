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
    
    var body: some View {
        
        GeometryReader { geomtry in
       
        ZStack(alignment: .topLeading) {
            Color.black.opacity(showMenu ? 0.7 : 0)
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
                                        if tab.rawValue == "Logout" {
                                            authViewModel.signOut()
                                            coordinator.dismissFullScreen()
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
//            .frame(width: geomtry.size.width / 2, height: geomtry.size.height )
        }
        
    }
}

#Preview {
    SideMenuView(showMenu: .constant(true), selectedTab: .constant(.Dashboard))
}
