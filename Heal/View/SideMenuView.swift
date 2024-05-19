//
//  SideMenuView.swift
//  Heal
//
//  Created by Yousuf Abdelfattah on 19/05/2024.
//

import SwiftUI

struct SideMenuView: View {
    @Binding var showMenu: Bool
    
    var body: some View {
        ZStack(alignment: .leading) {
            VStack(alignment: .leading, spacing: 30) {
                Button(action: {
                    withAnimation {
                        showMenu = false
                    }
                }) {
                    Image(systemName: "slider.horizontal.3")
                        .foregroundColor(.black)
                        .padding()
                }
                
                Text("Dashboard")
                    .font(.title2)
                    .padding(.leading)
                
                Text("Profile")
                    .font(.title2)
                    .padding(.leading)
                
                Text("Rewards")
                    .font(.title2)
                    .padding(.leading)
                
                Text("Logout")
                    .font(.title2)
                    .padding(.leading)
                
                Spacer()
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Color.blue.opacity(0.1))
            .clipShape(RoundedRectangle(cornerRadius: 25))
            .padding()
            .frame(width: 250, height: 100)
            .onTapGesture {
                withAnimation {
                    showMenu = false
                }
            }
            
        }
    }
}

//#Preview {
//    SideMenuView()
//}
