//
//  File.swift
//  
//
//  Created by Quentin PIDOUX on 16/05/2020.
//

import Foundation
import RxSwift
import DomainLayer

open class CommentsRepository: CommentsRepositorySource {

	private let remoteSource: CommentDataSource

	public init(commentSource: CommentDataSource) {
		self.remoteSource = commentSource
	}

	public func getCommentsForPost(id: Int) -> Observable<[DomainLayer.CommentDomain]> {
		return remoteSource.getCommentForPost(id: id)
			.map { (input) -> [DomainLayer.CommentDomain] in
				CommentDataMapper().transform(input: input)
		}
	}
}
