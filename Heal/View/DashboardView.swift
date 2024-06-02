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
    @State var selectedPeriod : HealthPeriod = .Daily
    
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
            
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())],spacing: 10 ,content: {
                
                ForEach(manager.healthData.filter { $0.key.contains(selectedPeriod.rawValue) }.sorted(by: { $0.value.id  < $1.value.id }), id: \.key) { item in
                    CardView(healthDataModel: item.value)
                        .transition(.opacity)
                        .animation(.easeInOut(duration: 0.2), value: selectedPeriod)
                }
                
                
            })
            .padding()
            
        }
        .background( showMenu ? .black.opacity(0.3) : .clear)
        
    }
    
    var buttons : some View {
        
        HStack(alignment: .center) {
            CustomButton(title: "Daily") {
                //Button Action
                changePeriod(to: .Daily)
            }
            
            Spacer()
            
            CustomButton(title: "Weekly") {
                //Button Action
                changePeriod(to: .Weekly)
            }
            Spacer()
            CustomButton(title: "Monthly") {
                //Button Action
                changePeriod(to: .Monthly)
                
            }
            
        }
        .padding()
        
    }
    
    private func changePeriod(to period: HealthPeriod) {
            withAnimation {
                selectedPeriod = period
            }
        }
    
    
}

enum HealthPeriod: String {
    case Daily, Weekly, Monthly
}

#Preview {
    DashboardView()
}
