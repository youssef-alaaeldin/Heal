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
    
    @State private var isSignInScreen = false
    var body: some View {
        ZStack {
            
            VStack {
                Image(uiImage: UIImage(named: "logo")!)
                HStack (alignment: .top) {
                    
                    VStack {
                        Image("mediuemEclipse")
                            .padding(.top, isSignInScreen ? 320 : 400)
                    }
                    VStack {
                        Image("smallEclipse")
                            .padding(.top, isSignInScreen ? 420 : 0)
                            
                    }
                    VStack {
                        Image("bigEclipse")
                    }
                }
                .animation(.default, value: isSignInScreen)
                .padding()
            }
            
            withAnimation {
                Rectangle()
                    .frame(width: 374 , height: isSignInScreen ? 320 : 400)
                    .background(.ultraThinMaterial)
                    .blur(radius: 5)
                    .cornerRadius(20)
                    .foregroundColor(.clear)
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(.white.opacity(0.3), lineWidth: 1)
                    )
                
                    .padding(.top, 220)
            }
            
            
            VStack (alignment: .leading, spacing: 25) {
                Text(isSignInScreen ? "Sign In" : "Sign Up")
                    .font(.custom("Lato-Reuglar", size: 30))
                    .foregroundColor(.primary)
                    .padding(.top, 60)
                
                if !isSignInScreen {
                    CustomTF(value: $fullName , hint: "Full Name")
                    
                }
                CustomTF(value: $email , hint: "Email")
                CustomTF(value: $password , hint: "Password")
                
                if !isSignInScreen {
                    signUpPolicty
                }
                
                
                
                VStack (alignment: .center) {
                    button
                    
                    HStack(spacing: 0) {
                        Text( !isSignInScreen ? "Joined us before? " : "Didn't joined yet? ")
                            .font(.custom("Lato", size: 10))
                        Button {
                            isSignInScreen.toggle()
                        } label: {
                            Text(isSignInScreen ? "Sign Up" : "Sign In")
                                .font(.custom("Lato", size: 10))
                                .foregroundStyle(Colors.fontGreen.color())
                        }
                    }
                }
                
                
            }
            .padding(.horizontal, 50)
            .padding(.top, 150)
            
            
        }
    }
    
    var button: some View {
        Button(action: {
            
        }, label: {
            Text(isSignInScreen ? "Sign In" : "Continue")
                .font(.custom("Lato-Regular", size: 25))
        })
        .frame(width: 309, height: 37, alignment: .center)
        .background(Colors.buttonColor.color())
        .foregroundColor(.white)
        .clipShape(RoundedRectangle(cornerRadius: 6))
    }
    
    var signUpPolicty : some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack (spacing: 0) {
                Text("By Signing up, You’re agree to our ")
                    .font(.custom("Lato-Regular", size: 12))
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
    }
}

#Preview {
    RegisterView()
}
