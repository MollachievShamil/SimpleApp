//
//  AutoPosts.swift
//  simpleTestApp
//
//  Created by Шамиль Моллачиев on 26.07.2023.
//

import Foundation
struct AutoPostsResponse: Codable {
    var posts: [Post]
}

struct Post: Equatable, Codable {
    var id: Int
}
