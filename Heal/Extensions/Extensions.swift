//
//  Extensions.swift
//  Heal
//
//  Created by Yousuf Abdelfattah on 01/06/2024.
//

import Foundation
import HealthKit
//MARK: - Date Extensions -


extension Date {
    static var startOfToday: Date {
        Calendar.current.startOfDay(for: Date())
    }
    
    static var startOfWeek: Date {
        Calendar.current.date(from: Calendar.current.dateComponents([.yearForWeekOfYear, .weekOfYear], from: Date()))!
    }
    
    static var startOfMonth: Date {
        let components = Calendar.current.dateComponents([.year, .month], from: Date())
        return Calendar.current.date(from: components)!
    }
}

//MARK: - Double Extensions -


extension Double {
    
    func formattedTwoDecimal() -> String {
        String(format: "%.2f", self)
    }
    
    /// Converts the distance in meters to kilometers and returns it as a formatted string.
    func formattedKilometers() -> String {
        let kilometers = self / 1000
        return String(format: "%.2f", kilometers)
    }
    
    func formatedString() -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.minimumFractionDigits = 0
        
        return numberFormatter.string(from: NSNumber(value: self))!
    }
}

//MARK: - User Information Extensions -

extension HKBiologicalSex {
    var stringRepresentation: String {
        switch self {
        case .notSet:
            return "Not Set"
        case .female:
            return "Female"
        case .male:
            return "Male"
        case .other:
            return "Other"
        @unknown default:
            return "Unknown"
        }
    }
}

extension HKBloodType {
    var stringRepresentation: String {
        switch self {
        case .notSet:
            return "Not Set"
        case .aPositive:
            return "A+"
        case .aNegative:
            return "A-"
        case .bPositive:
            return "B+"
        case .bNegative:
            return "B-"
        case .abPositive:
            return "AB+"
        case .abNegative:
            return "AB-"
        case .oPositive:
            return "O+"
        case .oNegative:
            return "O-"
        @unknown default:
            return "Unknown"
        }
    }
}

extension String {
    func extractFirstName() -> String {
        let components = self.split(separator: " ")
        return components.first.map(String.init) ?? ""
    }
}
