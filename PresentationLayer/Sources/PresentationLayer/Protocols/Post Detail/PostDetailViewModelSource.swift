//
//  File.swift
//  
//
//  Created by Quentin PIDOUX on 21/05/2020.
//

import Foundation

import RxSwift
import RxRelay

protocol PostDetailStateViewModelSource {
	var state: Observable<PostDetailState> {get set}
	var privateState: BehaviorRelay<PostDetailState> {get set}
	var disposeBag: DisposeBag {get}

	func getPostById(id: Int)
}
