//
//  SleepingAnalysisView.swift
//  Heal
//
//  Created by Yousuf Abdelfattah on 19/05/2024.
//

import SwiftUI

struct SleepingAnalysisView: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25)
                .fill(LinearGradient(colors: [Colors.startColor.color(), Colors.endColor.color()], startPoint: .topLeading, endPoint: .bottomTrailing))
                .frame(height: 307)
            
            VStack(alignment: .center){
                Text("Sleep Analysis")
                    .font(.system(size: 25))
                    .bold()
                    .padding(.top, 20)
                
                HStack(spacing: 20) {
                    CircularProgressView(progress: 80.4)
                    
                    VStack(alignment: .center, spacing: 3) {
                        Text("7h 30m")
                            .font(.system(size: 25))
                            .bold()
                        Text("Sleep Duration")
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
            
            HStack {
                Spacer()
                AppImage.sleepingGirl.image()
                    .resizable()
                    .scaledToFit()
                    .frame(height: 128)
                    .offset(y: 110)
            }
            
        }
        .padding()
    }
}

#Preview {
    SleepingAnalysisView()
}
