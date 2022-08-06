//
//  DataManager.swift
//  SimbirSoftInternship
//
//  Created by Trofim Petyanov on 28.06.2022.
//

import CoreData
import RealmSwift
import UIKit

struct DataManager {
	// MARK: – Data Key
	enum DataKey {
		static let helpCategoryResponse = "HelpCategories"
		static let helpEventResponse = "HelpEvents"
	}
	
	// MARK: – Properties
	static let isCoreData = true
	static let shared = DataManager()
	
	private var helpCategoriesResponse: [HelpCategoryResponse] {
		unarchiveJSON(key: DataKey.helpCategoryResponse) ?? []
	}
	
	private var helpEventsResponse: [HelpEventResponse] {
		unarchiveJSON(key: DataKey.helpEventResponse) ?? []
	}
	
	var helpCategories: [HelpCategory] {
		if DataManager.isCoreData {
			let coreDataStack = CoreDataStack(moduleName: "SimbirSoftInternship")
			let managedContext = coreDataStack.managedContext
			
			let request: NSFetchRequest<CDHelpCategory> = CDHelpCategory.fetchRequest()
			let cdHelpCategoriesCount = (try? managedContext.count(for: request)) ?? 0
			
			if cdHelpCategoriesCount > 0 {
				do {
					let result = try managedContext.fetch(request)
					
					return result.compactMap { HelpCategory(cdHelpCategory: $0) }.sorted(by: { $0.id < $1.id })
				} catch let error as NSError {
					print("Could not fetch \(error), \(error.userInfo)")
					
					return []
				}
			}
			
			insertCDHelpCategories(into: managedContext)
			coreDataStack.saveContext()
		} else {
			guard let realm = try? Realm() else { return [] }
			
			let rsHelpCategories = realm.objects(RSHelpCategory.self)
			
			if !rsHelpCategories.isEmpty {
				return rsHelpCategories.map { HelpCategory(rsHelpCategory: $0) }
			}
			
			insertRSHelpCategories()
		}
		
		let fetchedHelpCategories = fetchHelpCategories()
		
		if !fetchedHelpCategories.isEmpty {
			return fetchedHelpCategories.map { HelpCategory(helpCategoryResponse: $0) }.sorted(by: { $0.id < $1.id })
		} else {
			return helpCategoriesResponse.map { HelpCategory(helpCategoryResponse: $0) }.sorted(by: { $0.id < $1.id })
		}
	}
	
	var helpEvents: [HelpEvent] {
		if DataManager.isCoreData {
			let coreDataStack = CoreDataStack(moduleName: "SimbirSoftInternship")
			let managedContext = coreDataStack.managedContext
			
			let request: NSFetchRequest<CDHelpEvent> = CDHelpEvent.fetchRequest()
			let helpEventCount = (try? managedContext.count(for: request)) ?? 0
			
			if helpEventCount > 0 {
				do {
					let result = try managedContext.fetch(request)
					
					return result.compactMap { HelpEvent(cdHelpEvent: $0) }.sorted(by: { $0.id < $1.id })
				} catch let error as NSError {
					print("Could not fetch \(error), \(error.userInfo)")
					
					return []
				}
			}
			
			insertCDHelpEvents(into: managedContext)
			coreDataStack.saveContext()
		} else {
			guard let realm = try? Realm() else { return [] }
			
			let rsHelpEvents = realm.objects(RSHelpEvent.self)
			
			if !rsHelpEvents.isEmpty {
				return rsHelpEvents.map { HelpEvent(rsHelpEvent: $0) }
			}
			
			insertRSHelpEvents()
		}
		
		let fetchedHelpEvents = fetchHelpEvents()
		
		if !fetchedHelpEvents.isEmpty {
			return fetchedHelpEvents.map { HelpEvent(helpEventResponse: $0) }.sorted(by: { $0.id < $1.id })
		} else {
			return helpEventsResponse.map { HelpEvent(helpEventResponse: $0) }.sorted(by: { $0.id < $1.id })
		}
	}
	
	// MARK: – Init
	private init() { }
	
	// MARK: – Fetching
	func fetchHelpCategories() -> [HelpCategoryResponse] {
		var helpCategories = [HelpCategoryResponse]()
		
		HelpCategoriesRequest().send { result in
			switch result {
			case .success(let helpCategoriesResponse):
				helpCategories = helpCategoriesResponse
			case .failure(let error):
				print(error.localizedDescription)
				
				helpCategories = []
			}
		}
		
		return helpCategories
	}
	
	private func fetchHelpEvents() -> [HelpEventResponse] {
		var helpEvents = [HelpEventResponse]()
		
		HelpEventsRequest().send { result in
			switch result {
			case .success(let helpEventsResponse):
				helpEvents = helpEventsResponse
			case .failure(let error):
				print(error.localizedDescription)
				
				helpEvents = []
			}
		}
		
		return helpEvents
	}
	
	// MARK: – Insert in Core Data
	private func insertCDHelpCategories(into managedContext: NSManagedObjectContext) {
		var helpCategories = [HelpCategoryResponse]()
		
		let fetchedHelpCategories = fetchHelpCategories()
		if !fetchedHelpCategories.isEmpty {
			helpCategories = fetchedHelpCategories
		} else {
			helpCategories = helpCategoriesResponse
		}
		
		for helpCategoryResponse in helpCategories.sorted(by: { $0.id < $1.id }) {
			let entity = NSEntityDescription.entity(forEntityName: "CDHelpCategory", in: managedContext)!
			let cdHelpCategory = CDHelpCategory(entity: entity, insertInto: managedContext)
			
			cdHelpCategory.id = Int32(helpCategoryResponse.id)
			cdHelpCategory.name = helpCategoryResponse.name
			cdHelpCategory.imageName = helpCategoryResponse.imageName
			
			for eventId in helpCategoryResponse.eventIds {
				let entity = NSEntityDescription.entity(forEntityName: "CDEventId", in: managedContext)!
				let cdEventId = CDEventId(entity: entity, insertInto: managedContext)
				
				cdEventId.id = Int32(eventId)
				
				cdHelpCategory.insertIntoEventIds(cdEventId, at: cdHelpCategory.eventIds?.count ?? 0)
			}
		}
	}
	
	private func insertCDHelpEvents(into managedContext: NSManagedObjectContext) {
		var helpEvents = [HelpEventResponse]()
		
		let fetchedHelpEvents = fetchHelpEvents()
		if !fetchedHelpEvents.isEmpty {
			helpEvents = fetchedHelpEvents
		} else {
			helpEvents = helpEventsResponse
		}
		
		for helpEventResponse in helpEvents.sorted(by: { $0.id < $1.id }) {
			let entity = NSEntityDescription.entity(forEntityName: "CDHelpEvent", in: managedContext)!
			let cdHelpEvent = CDHelpEvent(entity: entity, insertInto: managedContext)
			
			cdHelpEvent.id = Int32(helpEventResponse.id)
			cdHelpEvent.name = helpEventResponse.name
			cdHelpEvent.shortDetail = helpEventResponse.shortDescription
			cdHelpEvent.startDate = helpEventResponse.startDate
			cdHelpEvent.endDate = helpEventResponse.endDate
			cdHelpEvent.fundName = helpEventResponse.fundName
			cdHelpEvent.address = helpEventResponse.address
			cdHelpEvent.contactLink = helpEventResponse.contactLink
			cdHelpEvent.detail = helpEventResponse.description
			cdHelpEvent.organizationLink = helpEventResponse.organizationLink
			cdHelpEvent.peopleCount = Int32(helpEventResponse.peopleCount)
			
			for phoneNumber in helpEventResponse.phoneNumbers {
				let entity = NSEntityDescription.entity(forEntityName: "CDPhoneNumber", in: managedContext)!
				let cdPhoneNumber = CDPhoneNumber(entity: entity, insertInto: managedContext)
				
				cdPhoneNumber.phoneNumber = phoneNumber
				
				cdHelpEvent.insertIntoPhoneNumbers(cdPhoneNumber, at: cdHelpEvent.phoneNumbers?.count ?? 0)
			}
			
			for imageName in helpEventResponse.imageNames {
				let entity = NSEntityDescription.entity(forEntityName: "CDImageName", in: managedContext)!
				let cdImageName = CDImageName(entity: entity, insertInto: managedContext)
				
				cdImageName.imageName = imageName
				
				cdHelpEvent.insertIntoImageNames(cdImageName, at: cdHelpEvent.imageNames?.count ?? 0)
			}
		}
	}
	
	// MARK: – Insert in Realm
	private func insertRSHelpCategories() {
		var helpCategories = [HelpCategoryResponse]()
		
		let fetchedHelpCategories = fetchHelpCategories()
		if !fetchedHelpCategories.isEmpty {
			helpCategories = fetchedHelpCategories
		} else {
			helpCategories = helpCategoriesResponse
		}
		
		for helpCategoryResponse in helpCategories.sorted(by: { $0.id < $1.id }) {
			let rsHelpCategory = RSHelpCategory(helpCategoryResponse: helpCategoryResponse)
			
			guard let realm = try? Realm() else { return }
			
			try? realm.write {
				realm.add(rsHelpCategory)
			}
		}
	}
	
	private func insertRSHelpEvents() {
		var helpEvents = [HelpEventResponse]()
		
		let fetchedHelpEvents = fetchHelpEvents()
		if !fetchedHelpEvents.isEmpty {
			helpEvents = fetchedHelpEvents
		} else {
			helpEvents = helpEventsResponse
		}
		
		for helpEventResponse in helpEvents.sorted(by: { $0.id < $1.id }) {
			let rsHelpEvent = RSHelpEvent(helpEventResponse: helpEventResponse)
			
			guard let realm = try? Realm() else { return }
			
			try? realm.write {
				realm.add(rsHelpEvent)
			}
		}
	}
	
	// MARK: – JSON Reading
	private func unarchiveJSON<T: Decodable>(key: String) -> T? {
		guard
			let filepath = Bundle.main.path(forResource: key, ofType: "json"),
			let string = try? String(contentsOfFile: filepath),
			let data = string.data(using: .utf8)
		else {
			print("Error while reading a JSON file")
			
			return nil
		}
		
		do {
			return try JSONDecoder().decode(T.self, from: data)
		} catch {
			print("Error while decoding a JSON file")
			
			return nil
		}
	}
}
