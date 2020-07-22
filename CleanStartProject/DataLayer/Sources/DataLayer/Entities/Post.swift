//
//  Post.swift
//  DataLayer
//
//  Created by Quentin PIDOUX on 12/05/2020.
//  Copyright © 2020 Quentin PIDOUX. All rights reserved.
//

import Foundation

open class PostData {
	public let userID, id: Int
	public let title, body: String

	public init(userID: Int, id: Int, title: String, body: String) {
		self.userID = userID
		self.id = id
		self.title = title
		self.body = body
	}
}
