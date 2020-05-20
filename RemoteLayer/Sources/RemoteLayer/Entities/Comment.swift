//
//  File.swift
//  
//
//  Created by Quentin PIDOUX on 16/05/2020.
//

import Foundation

public struct CommentRemote: Codable {
    public let postID, id: Int
    public let name, email, body: String

    enum CodingKeys: String, CodingKey {
        case postID = "postId"
        case id, name, email, body
    }
}
