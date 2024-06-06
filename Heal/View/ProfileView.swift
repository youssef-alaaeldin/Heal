//
//  ProfileView.swift
//  Heal
//
//  Created by Yousuf Abdelfattah on 22/05/2024.
//

import SwiftUI

struct ProfileView: View {
    
    @EnvironmentObject var manager: HealthManager
    @EnvironmentObject var authViewModel: AuthViewModel
    var body: some View {
        
        
        if let user = authViewModel.currentUser {
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
                        
                        Image(.profilePicMan)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 210)
                        
                        
                    }
                    .padding()
                    .frame(width: 273, height: 273)
                    //            .background(.black)
                    
                    VStack(alignment: .center){
                        Text(user.fullName)
                            .font(.system(size: 32, weight: .medium))
                        Text("Premium Member")
                            .font(.system(size: 15, weight: .light))
                    }
                    .padding()
                    
                    //                Spacer()
                    
                    List {
                        Section(header: Text("Informations")) {
                            listProfileView(title: "Sex", value: manager.healthData["BiologicalSex"]?.value ?? "Not Set")
                            listProfileView(title: "Blood Type", value: manager.healthData["BloodType"]?.value ?? "Not Set")
                        }
                        Section(header: Text("Physical Metrics")) {
                            listProfileView(title: "Weight (Kg)", value: manager.healthData["Weight"]?.value ?? "Not Set")
                            listProfileView(title: "Height (M)", value: manager.healthData["Height"]?.value ?? "Not Set")
                            listProfileView(title: "Body Mass Index (BMI)", value: manager.healthData["BMI"]?.value ?? "Not Set")
                        }
                    }
                    .scrollContentBackground(.hidden)
    //                .padding(.top, 10)
                }
            }
            .padding(.top, 60)
        }
        
        
        
        
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
