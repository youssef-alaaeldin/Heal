//
//  RegisterView.swift
//  Heal
//
//  Created by Yousuf Abdelfattah on 17/05/2024.
//

import SwiftUI

struct RegisterView: View {
    
    @State var fullName: String = ""
    @State var email: String = ""
    @State var password: String = ""
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
                .frame(width: 374 , height: 425)
                .background(.ultraThinMaterial)
                .blur(radius: 5)
                .cornerRadius(20)
                .foregroundColor(.clear)
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(.white.opacity(0.3), lineWidth: 1)
                )
                
                .padding(.top, 220)
            
            
            VStack (alignment: .leading, spacing: 38) {
                Text("Sign Up")
                    .font(.custom("Lato-Bold", size: 30))
                    .foregroundColor(.primary)
                
                CustomTF(value: $fullName , hint: "Full Name")
                CustomTF(value: $email , hint: "Email")
                CustomTF(value: $password , hint: "Password")
                
                VStack(alignment: .leading, spacing: 0) {
                    HStack (spacing: 0) {
                        Text("By Signing up, You’re agree to our ")
                            .font(.custom("Lato", size: 12))
                            .foregroundColor(Colors.fontGray.color())
                        Text("Terms & Conditions")
                            .font(.custom("Lato", size: 12))
                            .foregroundColor(Colors.fontGreen.color())
                    }
                    HStack (spacing: 0) {
                        Text("and ")
                            .font(.custom("Lato", size: 12))
                            .foregroundColor(Colors.fontGray.color())
                        Text("Privacy Policy")
                            .font(.custom("Lato", size: 12))
                            .foregroundColor(Colors.fontGreen.color())
                    }
                }
                .padding(.horizontal, 10)
                
                
                
                VStack (alignment: .center) {
                    Button(action: {
                        
                    }, label: {
                        /*@START_MENU_TOKEN@*/Text("Button")/*@END_MENU_TOKEN@*/
                    })
                    .background(Colors.buttonColor.color())
                    .foregroundColor(.white)
                    .controlSize(.large)
                    .frame(width: 309, height: nil, alignment: .center)
                    Text("Joined us before?  Sign In")
                        .font(.custom("Lato", size: 10))
                }
                   
                
            }
            .padding(.horizontal, 50)
            .padding(.top, 150)
            
            
           
            
            
        }
    }
}

#Preview {
    RegisterView()
}
