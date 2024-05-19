//
//  CircularProgressView.swift
//  Heal
//
//  Created by Yousuf Abdelfattah on 19/05/2024.
//

import SwiftUI

struct CircularProgressView: View {
    var progress: Double
    private let frameHeight : CGFloat = 130
    private let frameWidth : CGFloat = 130
        var body: some View {
            ZStack {
                Circle()
                    .trim(from: 0.0, to: 1.0)
                    .stroke(.white, lineWidth: 10)
                    .frame(width: frameWidth, height: frameHeight)
                
                Circle()
                    .trim(from: 0.0, to: progress / 100)
                    .stroke(
                        Colors.progressColor.color(),
                        style: StrokeStyle(lineWidth: 10, lineCap: .round)
                    )
                    .rotationEffect(Angle(degrees: -90))
                    .frame(width: frameWidth, height: frameHeight)
                
                VStack {
                    Text("Quality")
                        .font(.system(size: 14))
                        .fontWeight(.thin)
                    Text("\(String(format: "%.1f", progress)) %")
                        .font(.system(size: 25))
                        .bold()
                }
            }
        }
}

#Preview {
    CircularProgressView(progress: 80.4)
}
