//
//  File.swift
//  
//
//  Created by Quentin PIDOUX on 22/05/2020.
//

import Foundation
import RxSwift

public protocol PostDataCacheSource {
	func create(data: PostData) -> Completable

	func fetchAll() -> Observable<[PostData]>

	/// Tell is element is cached, if present check if it respect cache policy
	/// - Parameter id: postId
	func isCached(id: Int) -> Observable<Bool>

	func fetch(id: Int) -> Observable<PostData>

	func delete(id: Int) -> Completable
}
