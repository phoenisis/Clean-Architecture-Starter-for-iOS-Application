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
import DomainLayer

open class PostDetailStateViewModel: PostDetailStateViewModelSource {
	private var view: PostDetailViewProtocol?

	internal var state: Observable<PostDetailState>
	internal var privateState = BehaviorRelay(value: PostDetailState())
	internal let disposeBag = DisposeBag()

	private let useCase: DomainLayer.PostsUseCase

	public init(useCase: PostsUseCase, view: PostDetailViewProtocol?) {

		self.useCase = useCase
		self.view = view
		self.state = privateState.observeOn(MainScheduler.instance)

		self.state.subscribe { event in
			guard let state = event.element else { return }

			self.view?.viewUpdateWith(state: state)
		}.disposed(by: disposeBag)
	}

	public func getPostById(id: Int) {
		var state: PostDetailState = {
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
