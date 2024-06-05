//
//  RewardsCard.swift
//  Heal
//
//  Created by Yousuf Abdelfattah on 05/06/2024.
//

import SwiftUI

struct RewardsCard: View {
    
    @State var totalSteps: Double
    @EnvironmentObject var authViewModel: AuthViewModel
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25)
                .fill(LinearGradient(colors: [Colors.startColor.color(), Colors.endColor.color()], startPoint: .topLeading, endPoint: .bottomTrailing))
                .frame(height: 307)
            
            
            ZStack {
                VStack(alignment: .center) {
                    Text("\(authViewModel.currentUser?.fullName.extractFirstName() ?? "") has acheived \(Int(totalSteps)) steps today.")
                        .font(.system(size: 23))
                        .offset(x: 0, y: 30)
                    
                    HStack {
                        Image(.goldenTrophy)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                        Image(.confetti2)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    }
                }
                .padding()
            }
            
            
        }
        .padding()
    }
}

//#Preview {
//    RewardsCard()
//}
