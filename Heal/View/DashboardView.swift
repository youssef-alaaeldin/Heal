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
            
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], content: {
                
                ForEach(manager.healthData.filter { $0.key.contains(selectedPeriod.rawValue) }.sorted(by: { $0.value.id  < $1.value.id }), id: \.key) { item in
                    CardView(healthDataModel: item.value)
                }
                
            })
            .padding()
            
        }
        .background( showMenu ? .black.opacity(0.3) : .white)
        
    }
    
    var buttons : some View {
        
        HStack(alignment: .center) {
            CustomButton(title: "Daily") {
                //Button Action
                withAnimation {
                    selectedPeriod = .Daily
                }
            }
            
            Spacer()
            
            CustomButton(title: "Weekly") {
                //Button Action
                withAnimation {
                    selectedPeriod = .Weekly
                }
            }
            Spacer()
            CustomButton(title: "Monthly") {
                //Button Action
                withAnimation {
                    selectedPeriod = .Monthly
                }
                
            }
            
        }
        .padding()
        
    }
    
    private func filteredHealthData() -> [String: HealthData] {
        switch selectedPeriod {
        case .Daily:
            return manager.healthData.filter { $0.key.contains("today") }
        case .Weekly:
            return manager.healthData.filter { $0.key.contains("weekly") }
        case .Monthly:
            return manager.healthData.filter { $0.key.contains("monthly") }
        }
    }
    
}

enum HealthPeriod: String {
    case Daily, Weekly, Monthly
}

#Preview {
    DashboardView()
}
