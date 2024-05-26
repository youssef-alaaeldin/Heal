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
    
    @EnvironmentObject var manager: HealthManager
    var body: some View {
        
        
        ScrollView {
            
            VStack(alignment: .center) {
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
            
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], content: {
                
                ForEach(manager.healthData.sorted(by: { $0.value.id  < $1.value.id }), id: \.key) { item in
                    CardView(healthDataModel: item.value)
                    
                }
            })
            .padding()
            
        }
        .background( showMenu ? .black.opacity(0.3) : .white)
//        .onAppear {
//            manager.fetchTodaySteps()
//        }
        
        
    }
    
    
    
    
    var buttons : some View {
        
        HStack(alignment: .center) {
            CustomButton(title: "Daily") {
                //Button Action
            }
            Spacer()
            
            CustomButton(title: "Weekly") {
                //Button Action
            }
            Spacer()
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
