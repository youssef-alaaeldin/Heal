//
//  CircularProgressView.swift
//  Heal
//
//  Created by Yousuf Abdelfattah on 19/05/2024.
//

import SwiftUI

struct CircularProgressView: View {
    @State var animatedProgress : Double = 0.0
    @State var animatedTextProgress: Double = 0.0
    
    var progress: Double
    private let frameHeight : CGFloat = 130
    private let frameWidth : CGFloat = 130
    private let animationDuration: Double = 1.0
        var body: some View {
            ZStack {
                Circle()
                    .trim(from: 0.0, to: 1.0)
                    .stroke(.white, lineWidth: 10)
                    .frame(width: frameWidth, height: frameHeight)
                
                Circle()
                    .trim(from: 0.0, to: animatedProgress / 100)
                    .stroke(
                        Colors.progressColor.color(),
                        style: StrokeStyle(lineWidth: 10, lineCap: .round)
                    )
                    .rotationEffect(Angle(degrees: -90))
                    .frame(width: frameWidth, height: frameHeight)
                    .animation(.easeInOut(duration: animationDuration), value: animatedProgress)
                
                VStack {
                    Text("Quality")
                        .font(.system(size: 14))
                        .fontWeight(.thin)
                    Text("\(String(format: "%.1f", animatedTextProgress)) %")
                        .font(.system(size: 25))
                        .bold()
                }
            }
            .onAppear {
                startAnimation()
            }
        }
    
    private func startAnimation() {
        animatedProgress = progress
        animatedTextProgress = 0.0
        
        Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { timer in
            
            if animatedTextProgress < progress {
                animatedTextProgress += progress / (animationDuration * 100)
            } else {
                animatedTextProgress = progress
                timer.invalidate()
            }
        }
    }
}

#Preview {
    CircularProgressView(progress: 80.4)
}
