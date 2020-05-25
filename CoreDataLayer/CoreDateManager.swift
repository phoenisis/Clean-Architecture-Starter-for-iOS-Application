//
//  CoreDateManager.swift
//  CoreDataLayer
//
//  Created by Quentin PIDOUX on 22/05/2020.
//  Copyright © 2020 Quentin PIDOUX. All rights reserved.
//

import Foundation
import CoreData

public class CoreDataManager {
	public static let shared = CoreDataManager()

	private let identifier: String = Bundle.main.bundleIdentifier!
	private let model			: String = "CoreDataModel"

	lazy public var persistentContainer: NSPersistentContainer = {
		let messageKitBundle = Bundle(identifier: self.identifier)
		let modelURL = messageKitBundle!.url(forResource: self.model, withExtension: "momd")!
		let managedObjectModel =  NSManagedObjectModel(contentsOf: modelURL)

		let container = NSPersistentContainer(name: self.model, managedObjectModel: managedObjectModel!)
		container.loadPersistentStores { (_, error) in
			if let err = error {
				fatalError("❌ Loading of store failed:\(err)")
			}
		}

		return container
	}()
}
