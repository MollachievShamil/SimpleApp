//
//  AutoInfoResponse.swift
//  simpleTestApp
//
//  Created by Шамиль Моллачиев on 26.07.2023.
//

import Foundation

struct AutoInfoResponse: Equatable, Codable {
    static func == (lhs: AutoInfoResponse, rhs: AutoInfoResponse) -> Bool {
        lhs.car.id == rhs.car.id
    }
    
    var car: Car
}

struct Car: Codable {
    var id: Int
}
