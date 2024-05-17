//
//  RegisterView.swift
//  Heal
//
//  Created by Yousuf Abdelfattah on 17/05/2024.
//

import SwiftUI

struct RegisterView: View {
    
    @State var fullName: String = ""
    var body: some View {
        ZStack {
            VStack {
                Image(uiImage: UIImage(named: "logo")!)
                HStack (alignment: .top) {
                    Image("mediuemEclipse")
                        .padding(.top, 400)
                    Image("smallEclipse")
                    Image("bigEclipse")
                }
                .padding()
            }
            
            Rectangle()
                .frame(width: 374 , height: 400)
                .background(.ultraThinMaterial)
                .blur(radius: 5)
                .cornerRadius(20)
                .foregroundColor(.clear)
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(.white.opacity(0.3), lineWidth: 1)
                )
                .padding(.top, 220)
            
            
            VStack (alignment: .leading, spacing: 38){
                Text("Sign Up")
                    .font(.custom("Lato-Bold", size: 30))
                    .foregroundColor(.primary)
                
                CustomTF(value: $fullName , hint: "Full Name")
                
                
            }
            .padding(.horizontal, 50)
            
            
            
        }
    }
}

#Preview {
    RegisterView()
}
