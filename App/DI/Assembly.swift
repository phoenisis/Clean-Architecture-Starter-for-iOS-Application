//
//  Assembly.swift
//  CleanStartProject
//
//  Created by Quentin PIDOUX on 20/05/2020.
//  Copyright © 2020 Quentin PIDOUX. All rights reserved.
//

import Foundation
import Swinject

import RemoteLayer
import DataLayer
import DomainLayer
import PresentationLayer

class DataSourceAssembly: Assembly {
	func assemble(container: Container) {
		container.register(PostDataSource.self) { _ in
			PostSource()
		}

		container.register(CommentDataSource.self) { _  in
			CommentSource()
		}
	}
}

class RepositoryAssembly: Assembly {
	func assemble(container: Container) {
		container.register(PostsRepositorySource.self) { resolver in
			PostsRepository(postSource: resolver.resolve(PostDataSource.self)!)
		}

		container.register(CommentsRepositorySource.self) { resolver in
			CommentsRepository(commentSource: resolver.resolve(CommentDataSource.self)!)
		}
	}
}

class UseCaseAssembly: Assembly {
	func assemble(container: Container) {
		container.register(PostsUseCase.self) { resolver in
			PostsUseCase(postRepo: resolver.resolve(PostsRepositorySource.self)!, commentRepo: resolver.resolve(CommentsRepositorySource.self)!)
		}

		container.register(CommentUseCase.self) { resolver in
			CommentUseCase(commentRepo: resolver.resolve(CommentsRepositorySource.self)!)
		}
	}
}

extension Assembler {
	static let shared: Assembler = {
		let container = Container()
		return Assembler([
			DataSourceAssembly(),
			RepositoryAssembly(),
			UseCaseAssembly()
		], container: container)
	}()
}
