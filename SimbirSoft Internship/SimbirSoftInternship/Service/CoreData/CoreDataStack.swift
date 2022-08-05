//
//  CoreDataStack.swift
//  SimbirSoftInternship
//
//  Created by Trofim Petyanov on 05.08.2022.
//

import Foundation
import CoreData

class CoreDataStack {
	private let modelName: String
	
	private lazy var storeContainer: NSPersistentContainer = {
		let container = NSPersistentContainer(name: self.modelName)
		
		container.loadPersistentStores { _, error in
			if let error = error as NSError? {
				print("Unresolved error \(error), \(error.userInfo)")
			}
		}
		
		return container
	}()
	
	lazy var managedContext: NSManagedObjectContext = {
		return self.storeContainer.viewContext
	}()
	
	init(moduleName: String) {
		self.modelName = moduleName
	}
	
	func saveContext() {
		guard managedContext.hasChanges else { return }
		
		do {
			try managedContext.save()
		} catch let error as NSError {
			print("Unresolved error \(error), \(error.userInfo)")
		}
	}
}
