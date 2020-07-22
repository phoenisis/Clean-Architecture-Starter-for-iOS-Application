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
	private let cacheSource : PostDataCacheSource

	public init(postSource: PostDataSource, postCacheSource: PostDataCacheSource) {
		self.remoteSource = postSource
		self.cacheSource  = postCacheSource
	}

	public func getAllPosts() -> Observable<[DomainLayer.PostDomain]> {
		remoteSource.getAll()
			.map { (input) -> [DomainLayer.PostDomain] in
				PostDataMapper().transform(input: input)
		}
	}

	public func getPost(id: Int) -> Observable<DomainLayer.PostDomain> {
		cacheSource.isCached(id: id)
			.flatMap { (isCached) -> Observable<PostData> in
				if isCached {
					return self.cacheSource.fetch(id: id)
				} else {
					return self.remoteSource.getPost(id: id)
						.flatMap { (input) -> Observable<PostData> in
							self.cacheSource.create(data: input)
								.andThen(Observable.just(input))
					}
				}
		}.map { (input) -> DomainLayer.PostDomain in
			PostDataMapper().transform(input: input)
		}

	}
}
