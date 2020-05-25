//
//  PostCDSource.swift
//  CoreDataLayer
//
//  Created by Quentin PIDOUX on 22/05/2020.
//  Copyright © 2020 Quentin PIDOUX. All rights reserved.
//

import Foundation
import CoreData
import RxSwift
import Common
import DataLayer

public class PostCDSource: PostDataCacheSource {
	private typealias EntityType = PostCD
	private let entityName = "PostCD"
	private let context = CoreDataManager.shared.persistentContainer.viewContext

	public init() {}

	public func create(data: PostData) -> Completable {
		 return Completable.deferred { () -> PrimitiveSequence<CompletableTrait, Never> in
			guard let newData = NSEntityDescription.insertNewObject(forEntityName: self.entityName, into: self.context) as? EntityType else {
				print("❌ Failed to load \(self.entityName)")
				return Completable.empty()
			}

			newData.id 			  = Int64(data.id)
			newData.userID    = Int64(data.userID)
			newData.title		  = data.title
			newData.body 		  = data.body
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

	public func fetchAll() -> Observable<[PostData]> {
		let fetchRequest = NSFetchRequest<EntityType>(entityName: entityName)

		do {
			let datas = try context.fetch(fetchRequest)

			print("✅ \(entityName): \(datas.debugDescription)")
			return Observable.just(PostCDMapper().transform(input: datas))

		} catch let fetchErr {
			print("❌ Failed to fetch \(entityName):",fetchErr)
			return Observable.just([])
		}
	}

	public func fetch(id: Int) -> Observable<PostData> {
		let fetchRequest = NSFetchRequest<EntityType>(entityName: entityName)
		fetchRequest.predicate = NSPredicate(format: "id == %ld", id)

		do {
			let data = try context.fetch(fetchRequest)

			if data.count > 1 {
				print("❌ Failed to fetch \(entityName):", "Too many result")
				return Observable.error("\(entityName): Too many result")
			}
			if let data = data.first {
				print("✅ \(entityName) get: \(data.debugDescription)")

				return Observable.just(PostCDMapper().transform(input: data))
			}
			throw "\(entityName): element not found"
		} catch let fetchErr {
			print("❌ Failed to fetch \(entityName):",fetchErr)
			return Observable.error(fetchErr)
		}
	}

	public func delete(id: Int) -> Completable {
		return Completable.deferred { () -> PrimitiveSequence<CompletableTrait, Never> in
			let fetchRequest = NSFetchRequest<EntityType>(entityName: self.entityName)
			fetchRequest.predicate = NSPredicate(format: "id == %ld", id)

			do {
				let datas = try self.context.fetch(fetchRequest)

				for data in datas {
					self.context.delete(data)
				}
				print("✅ Succesfull to delete \(self.entityName):", "\(datas.count) element")
				return Completable.empty()
			} catch let fetchErr {
				print("❌ Failed to delete \(self.entityName):",fetchErr)
				return Completable.empty()
			}
		}
	}
}
