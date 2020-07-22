//
//  PostsUseCase.swift
//  DomainLayer
//
//  Created by Quentin PIDOUX on 14/05/2020.
//  Copyright © 2020 Quentin PIDOUX. All rights reserved.
//

import Foundation
import RxSwift

open class PostsUseCase {
	private let postsRepository: PostsRepositorySource
	private let commentRepository: CommentsRepositorySource

	public init(postRepo: PostsRepositorySource, commentRepo: CommentsRepositorySource) {
		self.postsRepository = postRepo
		self.commentRepository = commentRepo
	}

	public func getAll() -> Observable<[PostDomain]> {
		return postsRepository.getAllPosts()
	}

	public func getById(id: Int) -> Observable<PostDomain> {
		return postsRepository.getPost(id: id)
	}

	public func getCommentsForPost(id: Int) -> Observable<[CommentDomain]> {
		return commentRepository.getCommentsForPost(id: id)
	}

	public func getPostAndCommentFor(id: Int) -> Observable<(PostDomain, [CommentDomain])> {
		return Observable.zip(self.getById(id: id), self.getCommentsForPost(id: id))
	}
}
