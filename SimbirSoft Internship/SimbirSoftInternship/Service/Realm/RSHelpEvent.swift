//
//  RSHelpEvent.swift
//  SimbirSoftInternship
//
//  Created by Trofim Petyanov on 06.08.2022.
//

import Foundation
import RealmSwift

class RSHelpEvent: Object {
	@objc dynamic var id: Int = 0
	@objc dynamic var name: String = ""
	@objc dynamic var shortDetail: String = ""
	
	@objc dynamic var startDate = NSDate()
	@objc dynamic var endDate = NSDate()
	
	@objc dynamic var fundName: String = ""
	
	@objc dynamic var address: String = ""
	let phoneNumbers = List<String>()
	@objc dynamic var contactLink: String = ""
	
	let imageNames = List<String>()
	@objc dynamic var detail: String = ""
	
	@objc dynamic var organizationLink: String = ""
	
	@objc dynamic var peopleCount: Int = 0
	
	convenience init(helpEventResponse: HelpEventResponse) {
		self.init()
		id = helpEventResponse.id
		name = helpEventResponse.name
		shortDetail = helpEventResponse.shortDescription
		startDate = helpEventResponse.startDate as NSDate
		endDate = helpEventResponse.endDate as NSDate
		fundName = helpEventResponse.fundName
		address = helpEventResponse.address
		phoneNumbers.append(objectsIn: helpEventResponse.phoneNumbers)
		contactLink = helpEventResponse.contactLink
		imageNames.append(objectsIn: helpEventResponse.imageNames)
		detail = helpEventResponse.description
		organizationLink = helpEventResponse.organizationLink
		peopleCount = helpEventResponse.peopleCount
	}
}
