//
//  CircularProgressView.swift
//  Heal
//
//  Created by Yousuf Abdelfattah on 19/05/2024.
//

import SwiftUI

struct CircularProgressView: View {
    var progress: Double
        var body: some View {
            ZStack {
                Circle()
                    .trim(from: 0.0, to: 1.0)
                    .stroke(Color.gray.opacity(0.2), lineWidth: 20)
                    .frame(width: 150, height: 150)
                
                Circle()
                    .trim(from: 0.0, to: progress / 100)
                    .stroke(
                        LinearGradient(gradient: Gradient(colors: [Color.blue, Color.green]), startPoint: .topLeading, endPoint: .bottomTrailing),
                        style: StrokeStyle(lineWidth: 20, lineCap: .round)
                    )
                    .rotationEffect(Angle(degrees: -90))
                    .frame(width: 150, height: 150)
                
                VStack {
                    Text("Quality")
                        .font(.title3)
                        .foregroundColor(.black)
                    Text("\(String(format: "%.1f", progress)) %")
                        .font(.largeTitle)
                        .bold()
                        .foregroundColor(.black)
                }
            }
        }
}

#Preview {
    CircularProgressView(progress: 85)
}
