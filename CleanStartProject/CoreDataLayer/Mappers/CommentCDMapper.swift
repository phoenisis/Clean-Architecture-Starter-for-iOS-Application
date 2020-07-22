//
//  CommentCDMapper.swift
//  CleanStartProject
//
//  Created by Quentin PIDOUX on 22/05/2020.
//  Copyright © 2020 Quentin PIDOUX. All rights reserved.
//

import Foundation
import Common
import DataLayer

class CommentCDMapper: ViewModelType {
	typealias Input  = CommentCD
	typealias Output = DataLayer.CommentData

	func transform(input: Input) -> Output {
		//"N/A"
		Output(postID: Int(input.postID), id: Int(input.id), name: input.name ?? "N/A", email: input.email ?? "N/A", body: input.body ?? "N/A")
	}

	func transform(input: [Input]) -> [Output] {
		input.map { (input) -> Output in
			self.transform(input: input)
		}
	}
}
