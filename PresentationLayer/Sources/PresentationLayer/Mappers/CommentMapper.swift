//
//  CommentDataMapper.swift
//  CleanStartProject
//
//  Created by Quentin PIDOUX on 16/05/2020.
//  Copyright © 2020 Quentin PIDOUX. All rights reserved.
//

import Foundation
import Common
import DomainLayer

class CommentMapper: ViewModelType {
	typealias Input = DomainLayer.CommentDomain
	typealias Output = Comment

	func transform(input: Input) -> Output {
		return Output(postID: input.postID, id: input.id, name: input.name, email: input.email, body: input.body)
	}

	func transform(input: [Input]) -> [Output] {
		return input.map { (input) -> Output in
			self.transform(input: input)
		}
	}
}
