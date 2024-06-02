//
//  HealthData.swift
//  Heal
//
//  Created by Yousuf Abdelfattah on 26/05/2024.
//

import SwiftUI


struct HealthData: Equatable, Identifiable {
    let id: UUID
    let type: HealthDataType
    let value: String
//    let timePeriod: HealthPeriod
//    let date: Date
}

enum HealthDataType {
    
    case steps
    case distance
    case calories
    case heartRate
    
    case height
    case weight
    case bmi
    case bloodType
    case biologicalSex
    
    var image: Image {
        switch self {
        case .steps:
            return AppImage.runningGirl.image()
        case .distance:
            // will be replaced with walking girl
            return AppImage.standingGirl.image()
            
        case .calories:
            return AppImage.gymGirl.image()
        case .heartRate:
            return AppImage.heart.image()
            
        default:
            return AppImage.calories.image()
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
        case .heartRate:
            return "bpm"
            
        default:
            return ""
        }
    }
    
    var subtitle: String {
        switch self {
        case .steps:
            return ""
        case .distance:
            return "Walked"
        case .calories:
            return "Burned"
        case .heartRate:
            return "Avg heart rate"
        default:
            return ""
        }
    }
}
