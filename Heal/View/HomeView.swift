//
//  HomeView.swift
//  Heal
//
//  Created by Yousuf Abdelfattah on 19/05/2024.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
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
        
        ZStack {
            Rectangle()
                .frame(width: nil, height: 259)
                .cornerRadius(20)
                .foregroundStyle( LinearGradient(colors: [Colors.startColor.color(), Colors.endColor.color()], startPoint: .topLeading, endPoint: .bottomTrailing))
            VStack(alignment: .center){
                Text("Sleep Analysis")
                
                HStack {
                    Text("Circular Progress")
                    Spacer()
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
                
                AppImage.sleepingGirl.image()
            }
            .padding()
        }
        .padding()
        
        Spacer()

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
