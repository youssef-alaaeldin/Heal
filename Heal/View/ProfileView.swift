//
//  ProfileView.swift
//  Heal
//
//  Created by Yousuf Abdelfattah on 22/05/2024.
//

import SwiftUI

struct ProfileView: View {
    var body: some View {
        
        
        ZStack(alignment: .top) {
            VStack(spacing: 0) {
                ZStack {
                    Circle()
                        .stroke(.circle, lineWidth: 3)
                    Circle()
                        .foregroundStyle(
                            .profilePic
                        )
                        .padding(9)
                        .frame(width: 273, height: 273)
                    
                    Image(.profilePicGirl)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 210)
                    
                    
                }
                .padding()
                .frame(width: 273, height: 273)
                //            .background(.black)
                
                VStack(alignment: .center){
                    Text("Emily")
                        .font(.system(size: 32, weight: .medium))
                    Text("Premium Member")
                        .font(.system(size: 15, weight: .light))
                }
                .padding()
                
                //                Spacer()
                
                List {
                    Section(header: Text("Informations")) {
                        
                        listProfileView(title: "Sex", value: "Female")
                        listProfileView(title: "Blood Type", value: "Not Set")
                        
                    }
                    Section(header: Text("Physical Metrics")) {
                        
                        listProfileView(title: "Weight (Kg)", value: "100.9")
                        listProfileView(title: "Height (M)", value: "169")
                        listProfileView(title: "Body Mass Index (BMI)", value: "18")
                        
                    }
                }
//                .padding(.top, 10)
            }
        }
        .padding(.top, 60)
        
        
        
        
    }
}

struct listProfileView: View {
    
    var title: String
    var value: String
    var body: some View {
        HStack {
            Text(title)
            Spacer()
            Text(value)
                .foregroundStyle(.gray)
        }
        
    }
}

#Preview {
    ProfileView()
}
