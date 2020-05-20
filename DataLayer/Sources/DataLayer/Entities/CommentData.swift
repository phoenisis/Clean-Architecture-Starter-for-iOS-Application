//
//  File.swift
//  
//
//  Created by Quentin PIDOUX on 16/05/2020.
//

import Foundation

open class CommentData {
	public let postID, id: Int
	public let name, email, body: String

	public init(postID: Int, id: Int, name: String, email: String, body: String) {
		self.postID = postID
		self.id = id
		self.name = name
		self.email = email
		self.body = body
	}
}
