//
//  Color.swift
//  Heal
//
//  Created by Yousuf Abdelfattah on 17/05/2024.
//

import SwiftUI

enum Colors: String {
    case fontGreen
    case fontGray
    case buttonColor
    
    case startColor
    case endColor
    
    case progressColor
    
    func color() -> Color {
        return Color(self.rawValue)
    }
    
    func uiColor() -> UIColor? {
        return UIColor(named: self.rawValue)
    }
}
