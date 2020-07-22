//
//  File.swift
//  
//
//  Created by Quentin PIDOUX on 17/05/2020.
//

import Foundation
import RxSwift

public protocol CommentDataSource {

	func getAll() -> Observable<[CommentData]>

	func getCommentForPost(id: Int) -> Observable<[CommentData]>
}
