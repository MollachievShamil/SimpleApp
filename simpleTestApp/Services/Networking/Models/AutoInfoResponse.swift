//
//  AutoInfoResponse.swift
//  simpleTestApp
//
//  Created by Шамиль Моллачиев on 26.07.2023.
//

import Foundation

struct AutoInfoResponse: Hashable, Equatable, Codable {
    static func == (lhs: AutoInfoResponse, rhs: AutoInfoResponse) -> Bool {
        lhs.car.id == rhs.car.id
    }
    
    var car: Car
    var user: User
}

struct Car: Hashable, Codable {
    var id: Int
    var name: String
    var images: [CarImage]
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: Car, rhs: Car) -> Bool {
        lhs.id == rhs.id
    }
    
}

struct CarImage: Codable {
    var id: Int
    var isPrimary: Bool
    var url: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case isPrimary = "is_primary"
        case url
    }
}

struct User: Hashable, Equatable, Codable {
    var id: Int
    var username: String
    var avatar: AvatarModel
   
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: User, rhs: User) -> Bool {
        lhs.id == rhs.id
    }
}

struct AvatarModel: Codable {
    var url: String
    
}
