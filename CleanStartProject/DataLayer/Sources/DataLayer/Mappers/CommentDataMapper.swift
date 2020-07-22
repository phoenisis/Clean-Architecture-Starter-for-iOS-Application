//
//  File.swift
//  
//
//  Created by Quentin PIDOUX on 16/05/2020.
//

import Foundation
import Common
import DomainLayer

class CommentDataMapper: ViewModelType {
	typealias Input = CommentData
	typealias Output = CommentDomain

	func transform(input: Input) -> Output {
		return Output(postID: input.postID, id: input.id, name: input.name, email: input.email, body: input.body)
	}

	func transform(input: [Input]) -> [Output] {
		return input.map { (input) -> Output in
			self.transform(input: input)
		}
	}
}
