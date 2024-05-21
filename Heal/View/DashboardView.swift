//
//  HomeView.swift
//  Heal
//
//  Created by Yousuf Abdelfattah on 19/05/2024.
//

import SwiftUI

struct DashboardView: View {
    
    @State var showMenu = false
    
    @State var selectedTab : Tab = .Dashboard
    var body: some View {
        
        
        ScrollView {
            
            VStack(alignment: .leading) {
                HStack {
                    Text("Hey Emily,")
                        .font(.system(size: 46))
                        .bold()
                    
                    Spacer()
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
    DashboardView()
}
