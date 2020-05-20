//
//  File.swift
//  
//
//  Created by Quentin PIDOUX on 18/05/2020.
//

import Foundation
import RxSwift

public protocol CommentsRepositorySource {
	func getCommentsForPost(id: Int) -> Observable<[CommentDomain]>
}
