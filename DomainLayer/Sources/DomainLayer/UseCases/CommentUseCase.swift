//
//  File.swift
//  
//
//  Created by Quentin PIDOUX on 16/05/2020.
//

import Foundation
import RxSwift

open class CommentUseCase {
	private let repository: CommentsRepositorySource

	public init(commentRepo: CommentsRepositorySource) {
		self.repository = commentRepo
	}

	public func getForPost(id: Int) -> Observable<[CommentDomain]> {
		return repository.getCommentsForPost(id: id)
	}
}
