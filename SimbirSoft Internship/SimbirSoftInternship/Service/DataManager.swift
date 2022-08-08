//
//  DataManager.swift
//  SimbirSoftInternship
//
//  Created by Trofim Petyanov on 28.06.2022.
//

import CoreData
import RealmSwift
import UIKit
import Alamofire

struct DataManager {
	// MARK: – Data Key
	enum DataKey {
		static let helpCategoryResponse = "HelpCategories"
		static let helpEventResponse = "HelpEvents"
	}
	
	// MARK: – Properties
	static let isCoreData = true
	static let isURLSession = true
	static let shared = DataManager()
	
	private var helpCategoriesResponse: [HelpCategoryResponse] {
		unarchiveJSON(key: DataKey.helpCategoryResponse) ?? []
	}
	
	private var helpEventsResponse: [HelpEventResponse] {
		unarchiveJSON(key: DataKey.helpEventResponse) ?? []
	}
	
	func helpCategories(completion: @escaping ([HelpCategory]) -> Void) {
		if DataManager.isCoreData {
			let coreDataStack = CoreDataStack(moduleName: "SimbirSoftInternship")
			let managedContext = coreDataStack.managedContext

			let request: NSFetchRequest<CDHelpCategory> = CDHelpCategory.fetchRequest()
			let cdHelpCategoriesCount = (try? managedContext.count(for: request)) ?? 0

			if cdHelpCategoriesCount > 0 {
				do {
					let result = try managedContext.fetch(request)
					let helpCategories = result.compactMap { HelpCategory(cdHelpCategory: $0) }.sorted(by: { $0.id < $1.id })

					completion(helpCategories)
				} catch let error as NSError {
					print("Could not fetch \(error), \(error.userInfo)")

					completion([])
				}
			}

			insertCDHelpCategories(into: managedContext)
			coreDataStack.saveContext()
		} else {
			guard let realm = try? Realm() else {
				completion([])

				return
			}

			let rsHelpCategories = realm.objects(RSHelpCategory.self)

			if !rsHelpCategories.isEmpty {
				let helpCategories = rsHelpCategories.map { HelpCategory(rsHelpCategory: $0) } as [HelpCategory]

				completion(helpCategories)
			}

			insertRSHelpCategories()
		}
		
		if DataManager.isURLSession {
			fetchHelpCategories { fetchedHelpCategories in
				if !fetchedHelpCategories.isEmpty {
					let result = fetchedHelpCategories.map { HelpCategory(helpCategoryResponse: $0) }.sorted(by: { $0.id < $1.id })
					
					completion(result)
				} else {
					let result = helpCategoriesResponse.map { HelpCategory(helpCategoryResponse: $0) }.sorted(by: { $0.id < $1.id })
					
					completion(result)
				}
			}
		} else {
			fetchHelpCategoriesAF { fetchedHelpCategories in
				if !fetchedHelpCategories.isEmpty {
					let result = fetchedHelpCategories.map { HelpCategory(helpCategoryResponse: $0) }.sorted(by: { $0.id < $1.id })
					
					completion(result)
				} else {
					let result = helpCategoriesResponse.map { HelpCategory(helpCategoryResponse: $0) }.sorted(by: { $0.id < $1.id })
					
					completion(result)
				}
			}
		}
	}
	
	func helpEvents(completion: @escaping ([HelpEvent]) -> Void) {
		if DataManager.isCoreData {
			let coreDataStack = CoreDataStack(moduleName: "SimbirSoftInternship")
			let managedContext = coreDataStack.managedContext

			let request: NSFetchRequest<CDHelpEvent> = CDHelpEvent.fetchRequest()
			let helpEventCount = (try? managedContext.count(for: request)) ?? 0

			if helpEventCount > 0 {
				do {
					let result = try managedContext.fetch(request)
					let helpEvents = result.compactMap { HelpEvent(cdHelpEvent: $0) }.sorted(by: { $0.id < $1.id })

					completion(helpEvents)
				} catch let error as NSError {
					print("Could not fetch \(error), \(error.userInfo)")

					completion([])
				}
			}

			insertCDHelpEvents(into: managedContext)
			coreDataStack.saveContext()
		} else {
			guard let realm = try? Realm() else {
				completion([])

				return
			}

			let rsHelpEvents = realm.objects(RSHelpEvent.self)

			if !rsHelpEvents.isEmpty {
				let helpEvents = rsHelpEvents.map { HelpEvent(rsHelpEvent: $0) } as [HelpEvent]

				completion(helpEvents)
			}

			insertRSHelpEvents()
		}
		
		if DataManager.isURLSession {
			fetchHelpEvents { fetchedHelpEvents in
				if !fetchedHelpEvents.isEmpty {
					let helpEvents = fetchedHelpEvents.map { HelpEvent(helpEventResponse: $0) }.sorted(by: { $0.id < $1.id })
					
					completion(helpEvents)
				} else {
					let helpEvents = helpEventsResponse.map { HelpEvent(helpEventResponse: $0) }.sorted(by: { $0.id < $1.id })
					
					completion(helpEvents)
				}
			}
		} else {
			fetchHelpEventsAF { fetchedHelpEvents in
				if !fetchedHelpEvents.isEmpty {
					let helpEvents = fetchedHelpEvents.map { HelpEvent(helpEventResponse: $0) }.sorted(by: { $0.id < $1.id })
					
					completion(helpEvents)
				} else {
					let helpEvents = helpEventsResponse.map { HelpEvent(helpEventResponse: $0) }.sorted(by: { $0.id < $1.id })
					
					completion(helpEvents)
				}
			}
		}
	}
	
	// MARK: – Init
	private init() { }
	
	// MARK: – URLSession Fetching
	func fetchHelpCategories(completion: @escaping ([HelpCategoryResponse]) -> Void) {
		HelpCategoriesRequest().send { result in
			switch result {
			case .success(let helpCategoriesResponse):
				completion(helpCategoriesResponse)
			case .failure(let error):
				print(error.localizedDescription)
				
				completion([])
			}
		}
	}
	
	private func fetchHelpEvents(completion: @escaping ([HelpEventResponse]) -> Void) {
		HelpEventsRequest().send { result in
			switch result {
			case .success(let helpEventsResponse):
				completion(helpEventsResponse)
			case .failure(let error):
				print(error.localizedDescription)
				
				completion([])
			}
		}
	}
	
	// MARK: – Alamofire Fetching
	private func fetchHelpCategoriesAF(completion: @escaping ([HelpCategoryResponse]) -> Void) {
		HelpCategoriesRequest().sendWithAF { result in
			switch result {
			case .success(let helpEventsResponse):
				completion(helpEventsResponse)
			case .failure(let error):
				print(error.localizedDescription)
				
				completion([])
			}
		}
	}
	
	private func fetchHelpEventsAF(completion: @escaping ([HelpEventResponse]) -> Void) {
		HelpEventsRequest().send { result in
			switch result {
			case .success(let helpEventsResponse):
				completion(helpEventsResponse)
			case .failure(let error):
				print(error.localizedDescription)
				
				completion([])
			}
		}
	}
	
	// MARK: – Insert in Core Data
	private func insertCDHelpCategories(into managedContext: NSManagedObjectContext) {
		var helpCategories = [HelpCategoryResponse]()
		
		fetchHelpCategories { fetchedHelpCategories in
			if !fetchedHelpCategories.isEmpty {
				helpCategories = fetchedHelpCategories.sorted(by: { $0.id < $1.id })
			} else {
				helpCategories = helpCategoriesResponse.sorted(by: { $0.id < $1.id })
			}
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
		
		fetchHelpEvents { fetchedHelpEvents in
			if !fetchedHelpEvents.isEmpty {
				helpEvents = fetchedHelpEvents.sorted(by: { $0.id < $1.id })
			} else {
				helpEvents = helpEventsResponse.sorted(by: { $0.id < $1.id })
			}
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
		
		fetchHelpCategories { fetchedHelpCategories in
			if !fetchedHelpCategories.isEmpty {
				helpCategories = fetchedHelpCategories.sorted(by: { $0.id < $1.id })
			} else {
				helpCategories = helpCategoriesResponse.sorted(by: { $0.id < $1.id })
			}
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
		
		fetchHelpEvents { fetchedHelpEvents in
			if !fetchedHelpEvents.isEmpty {
				helpEvents = fetchedHelpEvents.sorted(by: { $0.id < $1.id })
			} else {
				helpEvents = helpEventsResponse.sorted(by: { $0.id < $1.id })
			}
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
