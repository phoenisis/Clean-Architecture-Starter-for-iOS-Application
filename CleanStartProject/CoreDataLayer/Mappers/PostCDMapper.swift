//
//  PostCDMapper.swift
//  CoreDataLayer
//
//  Created by Quentin PIDOUX on 22/05/2020.
//  Copyright © 2020 Quentin PIDOUX. All rights reserved.
//

import Foundation
import Common
import DataLayer

class PostCDMapper: ViewModelType {
	typealias Input  = PostCD
	typealias Output = DataLayer.PostData

	func transform(input: Input) -> Output {
		Output(userID: Int(input.userID), id: Int(input.id), title: input.title ?? "N/A", body: input.body ?? "N/A")
	}

	func transform(input: [Input]) -> [Output] {
		input.map { (input) -> Output in
			self.transform(input: input)
		}
	}
}
