//
//  File.swift
//  
//
//  Created by Quentin PIDOUX on 16/05/2020.
//

import Foundation
import Common
import DataLayer

class CommentRemoteMapper: ViewModelType {
	typealias Input = CommentRemote
	typealias Output = DataLayer.CommentData

	func transform(input: Input) -> Output {
		return Output(postID: input.postID, id: input.id, name: input.name, email: input.email, body: input.body)
	}

	func transform(input: [Input]) -> [Output] {
		return input.map { (input) -> Output in
			self.transform(input: input)
		}
	}
}
