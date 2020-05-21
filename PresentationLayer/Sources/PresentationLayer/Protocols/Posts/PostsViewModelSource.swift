//
//  File.swift
//  
//
//  Created by Quentin PIDOUX on 21/05/2020.
//

import Foundation
import RxSwift
import RxRelay

public protocol PostsStateViewModelSource {
	var state: Observable<PostState> {get set}
	var privateState: BehaviorRelay<PostState> {get set}
	var disposeBag: DisposeBag {get}

	func getAll()

	func showPostId(_ id: Int)
}
