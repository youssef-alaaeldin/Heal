//
//  CustomButton.swift
//  Heal
//
//  Created by Yousuf Abdelfattah on 19/05/2024.
//

import SwiftUI

struct CustomButton: View {
    
    var title: String
    
    var action: () -> Void
    
    var body: some View {
        
        

        
        Button(action: action) {
            Text(title)
        }
        .frame(width: 90, height: 50, alignment: .center)
        .background {
            LinearGradient(colors: [Colors.startColor.color(), Colors.endColor.color()], startPoint: .topLeading, endPoint: .bottomTrailing)
        }
        .foregroundStyle(.black)
        .clipShape(RoundedRectangle(cornerRadius: 8))
        
        
    }
}

//#Preview {
//    CustomButton()
//}
