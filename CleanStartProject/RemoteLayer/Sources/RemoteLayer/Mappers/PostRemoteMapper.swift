//
//  PostRemoteMapper.swift
//  DataLayer
//
//  Created by Quentin PIDOUX on 12/05/2020.
//  Copyright © 2020 Quentin PIDOUX. All rights reserved.
//

import Foundation
import Common
import DataLayer

class PostRemoteMapper: ViewModelType {
	typealias Input = PostRemote
	typealias Output = DataLayer.PostData

	func transform(input: Input) -> Output {
		return Output(userID: input.userID, id: input.id, title: input.title, body: input.body)
	}

	func transform(input: [Input]) -> [Output] {
		return input.map { (input) -> Output in
			self.transform(input: input)
		}
	}
}
