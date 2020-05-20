//
//  PostMapper.swift
//  RemoteLayer
//
//  Created by Quentin PIDOUX on 15/05/2020.
//  Copyright © 2020 Quentin PIDOUX. All rights reserved.
//

import Foundation
import Common
import DomainLayer

class PostMapper: ViewModelType {
	typealias Input = DomainLayer.PostDomain
	typealias Output = Post

	func transform(input: Input) -> Output {
		return Output(userID: input.userID, id: input.id, title: input.title, body: input.body)
	}

	func transform(input: [Input]) -> [Output] {
		return input.map { (input) -> Output in
			self.transform(input: input)
		}
	}
}
