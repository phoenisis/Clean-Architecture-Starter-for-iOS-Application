//
//  PostsRepository.swift
//  DataLayer
//
//  Created by Quentin PIDOUX on 14/05/2020.
//  Copyright © 2020 Quentin PIDOUX. All rights reserved.
//

import Foundation
import DomainLayer
import RxSwift

open class PostsRepository: PostsRepositorySource {
	private let remoteSource: PostDataSource

	public init(postSource: PostDataSource) {
		self.remoteSource = postSource
	}

	public func getAllPosts() -> Observable<[DomainLayer.PostDomain]> {
		remoteSource.getAll()
			.map { (input) -> [DomainLayer.PostDomain] in
				PostDataMapper().transform(input: input)
		}
	}

	public func getPost(id: Int) -> Observable<DomainLayer.PostDomain> {
		return remoteSource.getPost(id: id)
			.map { (input) -> DomainLayer.PostDomain in
				PostDataMapper().transform(input: input)
		}
	}
}
