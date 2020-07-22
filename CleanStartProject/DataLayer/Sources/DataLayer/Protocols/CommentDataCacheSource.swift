//
//  File.swift
//  
//
//  Created by Quentin PIDOUX on 22/05/2020.
//

import Foundation
import RxSwift

public protocol CommentDataCacheSource {
	func create(data: CommentData) -> Completable

	func create(data: [CommentData]) -> Completable

	func fetchAll() -> Observable<[CommentData]>

	func fetch(postID: Int) -> Observable<[CommentData]>

	func fetch(id: Int) -> Observable<CommentData?>

	func delete(id: Int)
}
