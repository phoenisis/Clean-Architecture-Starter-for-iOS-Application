//
//  PostsStateViewModel.swift
//  RemoteLayer
//
//  Created by Quentin PIDOUX on 15/05/2020.
//  Copyright © 2020 Quentin PIDOUX. All rights reserved.
//

import Foundation
import RxSwift
import RxRelay
import DomainLayer

open class PostsStateViewModel: PostsStateViewModelSource {
	private var view: PostViewProtocol?
	private var router: Router?

	public var state: Observable<PostState>
	public var privateState = BehaviorRelay(value: PostState())
	public let disposeBag = DisposeBag()

	private let useCase: DomainLayer.PostsUseCase?

	public init(useCase: DomainLayer.PostsUseCase, view: PostViewProtocol?, router: Router) {
		self.useCase = useCase
		self.view = view
		self.router = router
		self.state = privateState.observeOn(MainScheduler.instance)

		self.state.subscribe { event in
			guard let state = event.element else { return }

			self.view?.viewUpdateWith(state: state)
		}.disposed(by: disposeBag)
	}

	public func getAll() {
		var state: PostState = {
			var state = privateState.value
			state.loading = true
			state.posts = []
			state.error = nil
			state.empty = nil

			return state
		}()
		privateState.accept(state)

		useCase?.getAll()
			.subscribeOn(ConcurrentDispatchQueueScheduler(qos: .background))
			.map { (input) -> [Post] in
				PostMapper().transform(input: input)
		}
		.subscribe(onNext: { [weak self] (posts) in
			state.loading = false
			state.posts = posts
			if posts.isEmpty {
				state.empty = "Nothing to see here, move along."
			}
			self?.privateState.accept(state)

			}, onError: { [weak self] (error) in
				state.loading = false
				state.error = error.localizedDescription
				self?.privateState.accept(state)
		})
			.disposed(by: disposeBag)
	}

	public func showPostId(_ id: Int) {
		self.router?.route(to: "detail", parameters: id)
	}
}
