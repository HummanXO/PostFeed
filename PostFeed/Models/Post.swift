//
//  Post.swift
//  PostFeed
//
//  Created by Aleksandr on 30.04.2025.
//

import Foundation

struct Post: Codable {
    var userId: Int?
    var id: Int?
    var title: String
    var body: String
}
