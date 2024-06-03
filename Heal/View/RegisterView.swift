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
    @FocusState private var nameIsFocused: Bool
    
    @State private var isSignInScreen = false
    @State private var creatingUser = false // State to track if creating user
    @State private var signingIn = false // State to track if signing in
    
    @EnvironmentObject private var coordinator: Coordinator
    @EnvironmentObject private var authViewModel : AuthViewModel
    
    
    var body: some View {
//        if authViewModel.userSession != nil {
//            HomeView()
//        } else {
            ScrollView {
                
                ZStack {
                    
                    eclipses
                        .onTapGesture {
                            nameIsFocused = false
                        }
                    bluredRectangle
                        .onTapGesture {
                            nameIsFocused = false
                        }
                    content
                    
                    if creatingUser || signingIn {
                        ProgressView()
                            .padding()
                            .font(.system(size: 30))
                    }
                    
                }
                
            }
//        }
    }
    
    var content: some View {
        VStack (alignment: .leading, spacing: 25) {
            Text(isSignInScreen ? "Sign In" : "Sign Up")
                .font(.custom("Lato-Reuglar", size: 30))
                .foregroundColor(.primary)
                .padding(.top, 60)
            
            if !isSignInScreen {
                CustomTF(value: $fullName , hint: "Full Name")
            }
            CustomTF(value: $email , hint: "Email")
            CustomTF(value: $password , hint: "Password", isPassword: true)
            
            if !isSignInScreen {
                signUpPolicy
            }
            
            VStack (alignment: .center) {
                    button
                    
                
                HStack(spacing: 0) {
                    Text( !isSignInScreen ? "Joined us before? " : "Didn't joined yet? ")
                        .font(.custom("Lato", size: 10))
                        .foregroundStyle(Colors.fontGray.color())
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
        .animation(.easeIn(duration: 0.2), value: isSignInScreen)
    }
    
    var eclipses : some View {
        VStack {
            AppImage.logo.image()
            HStack (alignment: .top) {
                
                AppImage.mediuemEclipse.image()
                    .padding(.top, isSignInScreen ? 320 : 400)
                AppImage.smallEclipse.image()
                    .padding(.top, isSignInScreen ? 420 : 0)
                AppImage.bigEclipse.image()
                
            }
            .padding()
            .animation(.default, value: isSignInScreen)
            
        }
    }
    
    var bluredRectangle : some View {
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
            .animation(.easeInOut, value: isSignInScreen)
    }
    
    var button: some View {
        Button(action: {
            if !isSignInScreen {
                // SIGN UP
                creatingUser = true
                Task {
                    do {
                        try await authViewModel.createUser(withEmail: email, password: password, fullName: fullName)
                        coordinator.present(fullScreenCover: .home)
                    } catch {
                        print("Error creating user with error:  \(error.localizedDescription)")
                    }
                    creatingUser = false
                }
                
            }
            else {
                // LOGIN
                signingIn = true
                Task {
                    do {
                        try await authViewModel.signIn(withEmail: email, password: password)
                        	
                        coordinator.present(fullScreenCover: .home)
                    } catch {
                        print("Error signing in with error \(error.localizedDescription)")
                    }
                    signingIn = false
                }
                
            }
            
        }, label: {
            Text(isSignInScreen ? "Sign In" : "Continue")
                .font(.custom("Lato-Regular", size: 25))
        })
        .frame(width: 309, height: 37, alignment: .center)
        .background(Colors.buttonColor.color())
        .foregroundColor(.white)
        .clipShape(RoundedRectangle(cornerRadius: 6))
        .focused($nameIsFocused)
        .disabled(!isFormValid)
        .opacity(isFormValid ? 1 : 0.5)
        
    }
    
    var signUpPolicy : some View {
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

extension RegisterView: AuthFormValidation {
    var isFormValid: Bool {
        if !isSignInScreen {
            return !email.isEmpty
            && email.contains("@")
            && !password.isEmpty
            && !fullName.isEmpty
            && password.count > 5
        }
        
        return !email.isEmpty
        && email.contains("@")
        && !password.isEmpty
        && password.count > 5
    }
    
    
}

#Preview {
    RegisterView()
}
