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
}

struct Car: Hashable, Codable {
    var id: Int
    var carImage: String?
}
