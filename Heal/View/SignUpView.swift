//
//  SignUpView.swift
//  Heal
//
//  Created by Yousuf Abdelfattah on 17/05/2024.
//

import SwiftUI

struct SignUpView: View {
    @State private var fullName: String = ""
    @State private var emailOrMobile: String = ""
    @State private var password: String = ""
    
    var body: some View {
        VStack {
            Spacer()
            
            Text("heal")
                .foregroundColor(Color("healColor"))
            
            Spacer()
            
            VStack(alignment: .leading, spacing: 20) {
                Text("Sign Up")
                    .font(.title)
                    .fontWeight(.bold)
                
                TextField("Full Name", text: $fullName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                TextField("E-mail or Mobile Number", text: $emailOrMobile)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                SecureField("Password", text: $password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                Text("By Signing up, You’re agree to our Terms & Conditions and Privacy Policy")
                    .font(.footnote)
                    .foregroundColor(.gray)
                
                Button(action: {
                    // Handle sign up action
                }) {
                    Text("Continue")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                
                HStack {
                    Text("Joined us before?")
                        .foregroundColor(.gray)
                    Button(action: {
                        // Handle sign in action
                    }) {
                        Text("Sign In")
                            .foregroundColor(.blue)
                    }
                }
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 15)
                    .fill(Color.white)
                    .shadow(radius: 10)
            )
            .padding(.horizontal, 20)
            
            Spacer()
        }
        .background(
            VStack {
                Circle()
                    .fill(Color.blue.opacity(0.3))
                    .frame(width: 150, height: 150)
                    .offset(x: -150, y: -150)
                Spacer()
                Circle()
                    .fill(Color.blue.opacity(0.3))
                    .frame(width: 200, height: 200)
                    .offset(x: 150, y: 150)
            }
        )
        .edgesIgnoringSafeArea(.all)
    }
}


#Preview {
    SignUpView()
}
