//
//  SleepingAnalysisView.swift
//  Heal
//
//  Created by Yousuf Abdelfattah on 19/05/2024.
//

import SwiftUI

struct SleepingAnalysisView: View {
    
    @EnvironmentObject var healthManager: HealthManager
    @Binding var selectedPeriod: HealthPeriod
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25)
                .fill(LinearGradient(colors: [Colors.startColor.color(), Colors.endColor.color()], startPoint: .topLeading, endPoint: .bottomTrailing))
                .frame(height: 307)
            
            VStack(alignment: .center){
                Text("Standing Analysis")
                    .font(.system(size: 25))
                    .bold()
                    .padding(.top, 20)
                
                HStack(spacing: 20) {
                    CircularProgressView(progress: .constant(healthManager.standingProgress(for: selectedPeriod)))
//                    CircularProgressView(progress: .constant(84.0))
                    VStack(alignment: .center, spacing: 3) {
                        if selectedPeriod == .Daily {
                            Text("\(healthManager.standingTimeDaily.splitHoursAndMinutes().hours)h \(healthManager.standingTimeDaily.splitHoursAndMinutes().min)m")
                                .font(.system(size: 25))
                                .bold()
                        }
                        if selectedPeriod == .Weekly {
                            Text("\(healthManager.standingTimeWeekly.splitHoursAndMinutes().hours)h \(healthManager.standingTimeWeekly.splitHoursAndMinutes().min)m")
                                .font(.system(size: 25))
                                .bold()
                        }
                        if selectedPeriod == .Monthly {
                            Text("\(healthManager.standingTimeMonthly.splitHoursAndMinutes().hours)h \(healthManager.standingTimeMonthly.splitHoursAndMinutes().min)m")
                                .font(.system(size: 25))
                                .bold()
                        }
//                        Text("7h 30m")
//                            .font(.system(size: 25))
//                            .bold()
                        
                        Text("Standing Duration")
                            .font(.system(size: 16))
                            .fontWeight(.thin)
                        
                        HStack(spacing: 1.5) {
                            Image(systemName: "arrow.upright.circle")
                                .font(.system(size: 6))
                            Text("Slightly better than yesterday")
                                .font(.system(size: 6))
                                .fontWeight(.thin)
                        }
                    }
                    .padding()
                }
                .padding()
                            
            }
            .padding(.bottom, 100)
            
            HStack(alignment: .center) {
                AppImage.standingMan.image()
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200,height: 145)
                    .offset(x:25, y: 85)
            }
            
        }
        .padding()
    }
    
}

//#Preview {
//    SleepingAnalysisView(selectedPeriod: .constant(.Daily))
//}

extension Double {
    func splitHoursAndMinutes() -> (hours: Int, min: Int) {
        let hours = Int(self)
        let min = Int((self - Double(hours)) * 60)
        return (hours, min)
    }
}
