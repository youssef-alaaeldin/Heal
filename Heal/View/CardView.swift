//
//  CardView.swift
//  Heal
//
//  Created by Yousuf Abdelfattah on 22/05/2024.
//

import SwiftUI

struct CardView: View {
    
    @State var healthDataModel: HealthData
    var body: some View {
        ZStack {
            
            GeometryReader { geometry in
                
                ZStack(alignment: .leading) {
                    
                    healthDataModel.type.image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: geometry.size.width, height: geometry.size.height)
                        .padding(.leading, 40)
                    
                    VStack(alignment: .leading, spacing: 0) {
                        HStack(spacing: 0) {
                        
                            Text(healthDataModel.value)
                                .font(.title)
                                .bold()
                            
                            Text(healthDataModel.type.unit)
                                .font(.system(size: 13))
                                .bold()
                        }
                        
                        
                        Text(healthDataModel.type.subtitle)
                            .font(.system(size: 13, weight: .thin))
                    }
                    .padding(.bottom, 60)
                }
                .padding()
            }
            .frame(width: 177 , height: 154)
        }
        .background(
            LinearGradient(colors: [Colors.startColor.color(), Colors.endColor.color()], startPoint: .topLeading, endPoint: .bottomTrailing)
        )
        .clipShape(RoundedRectangle(cornerRadius: 25))
        
        
    }
}

//#Preview {
//    CardView()
//}
