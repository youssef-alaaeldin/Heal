//
//  HomeView.swift
//  Heal
//
//  Created by Yousuf Abdelfattah on 19/05/2024.
//

import SwiftUI

struct HomeView: View {
    
    @State private var showMenu = false
    var body: some View {
        
        ZStack {
            if showMenu {
                SideMenuView(showMenu: $showMenu)
                    .transition(.move(edge: .top))
                    .padding(.bottom, 300)
                    
            }
            
            ScrollView {
                
                VStack(alignment: .leading) {
                    HStack(alignment: .top) {
                        
                        VStack(alignment: .leading, spacing: 20) {
                            
                            
                            Button {
                                withAnimation {
                                    showMenu.toggle()
                                }
                            } label: {
                                Image(systemName: "slider.horizontal.3")
                            }
                            .buttonStyle(.plain)

                           
                            Text("Hey Emily,")
                                .font(.system(size: 46))
                                .bold()
                        }
                        Spacer()
                        Image(systemName: "bell")
                    }
                    .font(.system(size: 25))
                    .padding()
                    
                    buttons
                    
                }
                
                SleepingAnalysisView()
                
                Spacer()
                
            }
            .background( showMenu ? .black.opacity(0.3) : .white)
        }
    }
        
    
    
    
    var buttons : some View {
        
        HStack(alignment: .center, spacing: 45) {
            CustomButton(title: "Daily") {
                //Button Action
            }
            
            
            CustomButton(title: "Weekly") {
                //Button Action
            }
            
            CustomButton(title: "Monthly") {
                //Button Action
            }
            
        }
        .padding()
        
    }
    
}

#Preview {
    HomeView()
}
