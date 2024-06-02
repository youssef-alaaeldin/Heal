//
//  User.swift
//  Heal
//
//  Created by Yousuf Abdelfattah on 02/06/2024.
//

import Foundation

struct User: Identifiable, Codable {
    let id: String
    let fullName: String
    let email: String
    
    
    
}


extension User {
    static var MOCK_USER = User(id: NSUUID().uuidString, fullName: "Joe", email: "test@gmail.com")
}
