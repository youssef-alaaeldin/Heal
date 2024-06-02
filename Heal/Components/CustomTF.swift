//
//  CustomTF.swift
//  Heal
//
//  Created by Yousuf Abdelfattah on 17/05/2024.
//

import SwiftUI

struct CustomTF: View {
    
    @Binding var value: String
    var hint: String
    var isPassword = false
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 0){
            if isPassword {
                SecureField(hint, text: $value)
            } else {
                TextField(hint, text: $value)
                    .padding(.top, 10)
            }
            
            ZStack {
                Rectangle()
                    .fill(.primary.opacity(0.2))
                    
            }
            .frame(height: 2)
            
        }
        
        
        
        
        
    }
}

//#Preview {
//    CustomTF()
//}
