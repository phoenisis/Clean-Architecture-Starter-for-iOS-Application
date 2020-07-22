//
//  File.swift
//  
//
//  Created by Quentin PIDOUX on 16/05/2020.
//

import Foundation
import RxSwift
import DataLayer

open class CommentSource: CommentDataSource {
	public init() {}

	public func getAll() -> Observable<[DataLayer.CommentData]> {
		return RemoteManager().getAllComments()
			.map { (input) -> [DataLayer.CommentData] in
				CommentRemoteMapper().transform(input: input)
		}
	}

	public func getCommentForPost(id: Int) -> Observable<[DataLayer.CommentData]> {
		return RemoteManager().getCommentsFromPost(id: id)
			.map { (input) -> [DataLayer.CommentData] in
				CommentRemoteMapper().transform(input: input)
		}
	}
}
