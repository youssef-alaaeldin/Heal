//
//  File.swift
//  Heal
//
//  Created by Yousuf Abdelfattah on 19/05/2024.
//

import SwiftUI

enum AppImage: String {
    
    case logo
    case mediuemEclipse
    case smallEclipse
    case bigEclipse
    case gymGirl
    case sleepingGirl
    case tennisGirl
    case calories
    case yogaGirl
    case runningGirl
    
    func image() -> Image {
        return Image(self.rawValue)
    }
    
    func uiImage() -> UIImage {
        return UIImage(named: self.rawValue)!
    }
    
}
