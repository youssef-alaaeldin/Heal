//
//  CustomButton.swift
//  Heal
//
//  Created by Yousuf Abdelfattah on 19/05/2024.
//

import SwiftUI

struct CustomButton: View {
    
//    var action: () -> Void
    
    @Binding var selectedChoice: HealthPeriod
    
    var body: some View {
        HStack(alignment: .center) {
            ForEach(HealthPeriod.allCases, id: \.rawValue) { period in
                Spacer()
                Button(action: {
                    withAnimation {
                        selectedChoice = period
                    }
                }) {
                    ZStack {
                        Image(.smallEclipse)
                            .resizable()
                            .frame(width: 100, height: 100)
                            .opacity(selectedChoice == period ? 0.8 : 0)
                            .blendMode(.hardLight)
                        if period == .Daily {
                            Text("Daily")
                        }
                        if period == .Weekly {
                            Text("Weekly")
                        }
                        if period == .Monthly {
                            Text("Monthly")
                        }
                        
                    }
                    
                }
                .frame(width: 90, height: 50, alignment: .center)
                .background {
                    LinearGradient(colors: [Colors.startColor.color(), Colors.endColor.color()], startPoint: .topLeading, endPoint: .bottomTrailing)
                }
                .foregroundStyle(.primary)
                .clipShape(RoundedRectangle(cornerRadius: 8))
                
                Spacer()
                
            }
        }
        
    }
    
}


//#Preview {
//    CustomButton()
//}
