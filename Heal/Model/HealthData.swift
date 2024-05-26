//
//  HealthData.swift
//  Heal
//
//  Created by Yousuf Abdelfattah on 26/05/2024.
//

import SwiftUI


struct HealthData {
    let id: Int
    let type: HealthDataType
    let value: String
//    let date: Date
}

enum HealthDataType {
    
    case steps
    case distance
    case calories
    
    var image: Image {
        switch self {
        case .steps:
            return AppImage.runningGirl.image()
        case .distance:
            // will be replaced with walking girl
            return AppImage.runningGirl.image()
            
        case .calories:
            return AppImage.gymGirl.image()
        }
    }
    
    var unit: String {
        switch self {
        case .steps:
            return "Steps"
        case .distance:
            return "Km"
        case .calories:
            return "kcal"
        }
    }
}
