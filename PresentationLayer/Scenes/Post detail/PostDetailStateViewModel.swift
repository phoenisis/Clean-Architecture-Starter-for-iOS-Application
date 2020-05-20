//
//  PostDetailStateViewModel.swift
//  CleanStartProject
//
//  Created by Quentin PIDOUX on 16/05/2020.
//  Copyright © 2020 Quentin PIDOUX. All rights reserved.
//

import Foundation
import RxSwift
import RxRelay
import Swinject
import DomainLayer

protocol PostDetailViewProtocol {
	func viewUpdateWith(state: PostDetailStateViewModel.State)
}

class PostDetailStateViewModel {
	private let container = Container()
	private var view: PostDetailViewProtocol?
	public var state: Observable<State>

	struct State {
		var loading = false
		var post : Post?
		var comments: [Comment] = []
		var empty: String?
		var error: String?
		var cancel = false
	}

	private let privateState = BehaviorRelay(value: State())
	private let disposeBag = DisposeBag()

	private let useCase: DomainLayer.PostsUseCase

	init(view: PostDetailViewProtocol?) {

		useCase = Assembler.shared.resolver.resolve(PostsUseCase.self)!

		self.view = view
		self.state = privateState.observeOn(MainScheduler.instance)

		self.state.subscribe { event in
			guard let state = event.element else { return }

			self.view?.viewUpdateWith(state: state)
		}.disposed(by: disposeBag)
	}

	public func getPostById(id: Int) {
		var state: PostDetailStateViewModel.State = {
			var state = privateState.value
			state.loading = true
			state.post  = nil
			state.comments = []
			state.error = nil
			state.empty = nil

			return state
		}()
		privateState.accept(state)

		useCase.getPostAndCommentFor(id: id)
			.subscribeOn(ConcurrentDispatchQueueScheduler(qos: .background))
			.map({ (inputs) -> (Post, [Comment]) in
				(PostMapper().transform(input: inputs.0), CommentMapper().transform(input: inputs.1))
			})
			.subscribe(onNext: { [weak self] (post, comments) in
				state.loading = false
				state.post = post
				state.comments = comments
				self?.privateState.accept(state)
			}, onError: { [weak self] (error) in
				state.loading = false
				state.error = error.localizedDescription
				self?.privateState.accept(state)
			})
			.disposed(by: disposeBag)
		}
}
