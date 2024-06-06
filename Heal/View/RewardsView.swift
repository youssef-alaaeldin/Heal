//
//  RewardsView.swift
//  Heal
//
//  Created by Yousuf Abdelfattah on 03/06/2024.
//

import SwiftUI

struct RewardsView: View {
    @EnvironmentObject var healthManager: HealthManager
    var body: some View {
        if healthManager.goalAchieved {
            ZStack(alignment: .top) {
                VStack(spacing: 0) {
                    ZStack {
                        Image(.confetti)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 405, height: 374)
                            .rotationEffect(.degrees(-18.7))
                        
                        Circle()
                            .stroke(.circle, lineWidth: 3)
                            .frame(width: 273, height: 273)
                        Circle()
                            .foregroundStyle(
                                .profilePic
                            )
                            .padding(9)
                            .frame(width: 273, height: 273)
                        
                        Image(.rewards)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 210)
                    }
                    .padding()
                    .frame(width: 273, height: 273)
                    
                    VStack(alignment: .center){
                        Text("Congratulations!")
                            .font(.system(size: 32, weight: .medium))
                    }
                    .padding()
                    
                    RewardsCard(totalSteps: healthManager.totalSteps)
                }
            }
            .padding(.top, 60)
        }
        else {
            VStack {
                AppImage.lazyMan.image()
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 250)
                Text("Keep going to achieve your daliy steps !")
                Text("Your goal is \(Int(healthManager.dailyStepsGoal)) steps")
                    .bold()
            }
        }
    }
}

//#Preview {
//    RewardsView()
//}
