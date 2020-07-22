//
//  Post.swift
//  RemoteLayer
//
//  Created by Quentin PIDOUX on 15/05/2020.
//

import Foundation

public struct PostRemote: Codable {
	public let userID, id: Int
	public let title, body: String

	enum CodingKeys: String, CodingKey {
		case userID = "userId"
		case id, title, body
	}
}
