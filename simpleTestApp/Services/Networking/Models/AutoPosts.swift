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

struct Post: Hashable, Equatable, Codable {
    var id: Int
    var text: String
    var createdAt: String
    var img: String
    var commentCount: Int
    var likeCount: Int
    
    enum CodingKeys: String, CodingKey {
        case id
        case img
        case text
        case createdAt = "created_at"
        case likeCount = "like_count"
        case commentCount = "comment_count"
    }
}
