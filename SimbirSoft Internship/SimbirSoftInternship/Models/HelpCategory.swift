//
//  HelpCategory.swift
//  SimbirSoftInternship
//
//  Created by Trofim Petyanov on 28.06.2022.
//

import Foundation

struct HelpCategory {
	let id: Int
	let name: String
	let imageName: String
	let eventIds: [Int]
}

// MARK: – Response Init
extension HelpCategory {
	init(helpCategoryResponse: HelpCategoryResponse) {
		self.init(
			id: helpCategoryResponse.id,
			name: helpCategoryResponse.name,
			imageName: helpCategoryResponse.imageName,
			eventIds: helpCategoryResponse.eventIds
		)
	}
}

// MARK: – Core Data Init
extension HelpCategory {
	init?(cdHelpCategory: CDHelpCategory) {
		guard
			let name = cdHelpCategory.name,
			let imageName = cdHelpCategory.imageName,
			let eventIds = (cdHelpCategory.eventIds?.array as? [CDEventId])?.map({ Int($0.id) })
		else {
			print("Error initializing HelpCategory from CDHelpCategory")
			
			return nil
		}
		
		self.init(
			id: Int(cdHelpCategory.id),
			name: name,
			imageName: imageName,
			eventIds: eventIds
		)
	}
}

// MARK: – Realm Init
extension HelpCategory {
	init(rsHelpCategory: RSHelpCategory) {
		self.init(
			id: rsHelpCategory.id,
			name: rsHelpCategory.name,
			imageName: rsHelpCategory.imageName,
			eventIds: Array(rsHelpCategory.eventIds)
		)
	}
}
