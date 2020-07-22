//
//  CommentCDSource.swift
//  CleanStartProject
//
//  Created by Quentin PIDOUX on 22/05/2020.
//  Copyright © 2020 Quentin PIDOUX. All rights reserved.
//

import Foundation
import CoreData
import RxSwift
import Common
import DataLayer

public class CommentCDSource: CommentDataCacheSource {
	private typealias EntityType = CommentCD
	private let entityName = "CommentCD"
	private let context = CoreDataManager().persistentContainer.viewContext

	public init() {}

	public func create(data: CommentData) -> Completable {
		return Completable.deferred { () -> PrimitiveSequence<CompletableTrait, Never> in
			guard let newData = NSEntityDescription.insertNewObject(forEntityName: self.entityName, into: self.context) as? EntityType else {
				print("❌ Failed to load \(self.entityName)")
				return Completable.empty()
			}

			newData.id 			  = Int64(data.id)
			newData.postID    = Int64(data.postID)
			newData.email		  = data.email
			newData.body 		  = data.body
			newData.name 		  = data.name
			newData.createdAt = Date()

			do {
				try self.context.save()
				print("✅ \(self.entityName) saved succesfuly")
				return Completable.empty()
			} catch let error {
				print("❌ Failed to create \(self.entityName): \(error.localizedDescription)")
				return Completable.empty()
			}
		}
	}

	public func create(data: [CommentData]) -> Completable {
		return Completable.deferred { () -> PrimitiveSequence<CompletableTrait, Never> in

			for data in data {
				_ = self.create(data: data).subscribe()
			}

			return Completable.empty()

		}
	}

	public func fetchAll() -> Observable<[CommentData]> {
		let fetchRequest = NSFetchRequest<EntityType>(entityName: entityName)

		do {
			let datas = try context.fetch(fetchRequest)

			print("✅ \(entityName): \(datas.debugDescription)")

			return Observable.just(CommentCDMapper().transform(input: datas))

		} catch let fetchErr {
			print("❌ Failed to fetch \(entityName):",fetchErr)
			return Observable.just([])
		}
	}

	public func isCached(id: Int) -> Observable<Bool> {
		let fetchRequest = NSFetchRequest<EntityType>(entityName: entityName)
		fetchRequest.predicate = NSPredicate(format: "id == %ld", id)

		do {
			let datas = try context.fetch(fetchRequest)
			return Observable.just(!datas.isEmpty)
		} catch {
			return Observable.just(false)
		}
	}

	public func fetch(postID: Int) -> Observable<[CommentData]> {
		let fetchRequest = NSFetchRequest<EntityType>(entityName: entityName)
		fetchRequest.predicate = NSPredicate(format: "postID == %ld", postID)

		do {
			let data = try context.fetch(fetchRequest)

			print("✅ \(entityName): \(data.debugDescription)")

			return Observable.just(CommentCDMapper().transform(input: data))
		} catch let fetchErr {
			print("❌ Failed to fetch \(entityName):",fetchErr)
			return Observable.just([])
		}
	}

	public func fetch(id: Int) -> Observable<CommentData?> {
		let fetchRequest = NSFetchRequest<EntityType>(entityName: entityName)
		fetchRequest.predicate = NSPredicate(format: "id == %ld", id)

		do {
			let data = try context.fetch(fetchRequest)

			if data.count > 1 {
				print("❌ Failed to fetch \(entityName):", "Too many result")
				return Observable.just(nil)
			}
			if let data = data.first {
				print("✅ \(entityName) get: \(data.description)")
				return Observable.just(CommentCDMapper().transform(input: data))
			}
			return Observable.just(nil)
		} catch let fetchErr {
			print("❌ Failed to fetch \(entityName):",fetchErr)
			return Observable.just(nil)
		}
	}

	public func delete(id: Int) {
		let fetchRequest = NSFetchRequest<EntityType>(entityName: entityName)
		fetchRequest.predicate = NSPredicate(format: "id == %ld", id)

		do {
			let datas = try context.fetch(fetchRequest)

			for data in datas {
				context.delete(data)
			}
			print("✅ Succesfull to delete \(entityName):", "\(datas.count) element")
		} catch let fetchErr {
			print("❌ Failed to delete \(entityName):",fetchErr)
		}
	}
}
