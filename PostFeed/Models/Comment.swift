//
//  Comment.swift
//  PostFeed
//
//  Created by Aleksandr on 30.04.2025.
//

import Foundation

struct Comment: Codable {
    var postId: Int
    var id: Int
    var name: String
    var email: String
    var body: String
}
