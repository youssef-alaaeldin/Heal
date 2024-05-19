//
//  HomeView.swift
//  Heal
//
//  Created by Yousuf Abdelfattah on 19/05/2024.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        
        ScrollView {
            VStack(alignment: .leading) {
                HStack(alignment: .top) {
                    VStack(alignment: .leading, spacing: 20) {
                        Image(systemName: "slider.horizontal.3")
                        
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
