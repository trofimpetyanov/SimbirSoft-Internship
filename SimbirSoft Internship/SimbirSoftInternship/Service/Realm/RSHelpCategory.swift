//
//  RSHelpCategory.swift
//  SimbirSoftInternship
//
//  Created by Trofim Petyanov on 06.08.2022.
//

import Foundation
import RealmSwift

class RSHelpCategory: Object {
	@objc dynamic var id: Int = 0
	@objc dynamic var name: String = ""
	@objc dynamic var imageName: String = ""
	let eventIds = List<Int>()
	
	convenience init(helpCategoryResponse: HelpCategoryResponse) {
		self.init()
		id = helpCategoryResponse.id
		name = helpCategoryResponse.name
		imageName = helpCategoryResponse.imageName
		eventIds.append(objectsIn: helpCategoryResponse.eventIds)
	}
}

extension RSHelpCategory {
	override class func primaryKey() -> String? {
		return "id"
	}
}
