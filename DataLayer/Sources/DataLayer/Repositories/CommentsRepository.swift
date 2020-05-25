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

	private let remoteSource : CommentDataSource
	private let cacheSource  : CommentDataCacheSource

	public init(commentSource: CommentDataSource, commentCacheSource: CommentDataCacheSource) {
		self.remoteSource = commentSource
		self.cacheSource  = commentCacheSource
	}

	public func getCommentsForPost(id: Int) -> Observable<[DomainLayer.CommentDomain]> {
		cacheSource.fetch(postID: id)
			.flatMap { (inputs) -> Observable<[CommentData]> in
				if inputs.isEmpty {
					return self.remoteSource.getCommentForPost(id: id)
						.flatMap { (inputs) -> Observable<[CommentData]> in
							self.cacheSource.create(data: inputs)
							.andThen(Observable.just(inputs))
					}
				} else {
					return Observable.just(inputs)
				}
		}
		.map({ (input) -> [DomainLayer.CommentDomain] in
			CommentDataMapper().transform(input: input)
		})
	}
}
