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
    @EnvironmentObject var authViewModel: AuthViewModel
    
    var body: some View {
        
        
        ScrollView {
            VStack(alignment: .center) {
                HStack {
                    Text("Hey \(authViewModel.currentUser?.fullName ?? ""),")
                        .font(.system(size: 46))
                        .bold()
                    
                    Spacer()
                }
                .font(.system(size: 25))
                .padding()
                
//                buttons
                CustomButton(selectedChoice: $selectedPeriod)
                
            }
            
            SleepingAnalysisView()
            
            Spacer()
            
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())],spacing: 10 ,content: {
                
                ForEach(manager.healthData.filter { $0.key.contains(selectedPeriod.rawValue) }.sorted(by: { $0.value.id  < $1.value.id }), id: \.key) { item in
                    CardView(healthDataModel: item.value)
                        .transition(.opacity)
                        .animation(.spring(duration: 0.1), value: selectedPeriod)
                }
                
                
            })
            .padding()
            
        }
        .background( showMenu ? .black : .clear)
        
    }
    
    
}

enum HealthPeriod: String, CaseIterable {
    case Daily, Weekly, Monthly
}

#Preview {
    DashboardView()
}
