//
//  HelpEvent.swift
//  SimbirSoftInternship
//
//  Created by Trofim Petyanov on 12.07.2022.
//

import Foundation

struct HelpEvent {
	let id: Int
	let name: String
	let shortDescription: String
	
	let startDate: Date
	let endDate: Date
	
	let fundName: String
	
	let address: String
	let phoneNumbers: [String]
	let contactLink: String
	
	let imageNames: [String]
	let description: String
	
	let organizationLink: String
	
	let peopleCount: Int
}

// MARK: – Response Init
extension HelpEvent {
	init(helpEventResponse: HelpEventResponse) {
		self.init(
			id: helpEventResponse.id,
			name: helpEventResponse.name,
			shortDescription: helpEventResponse.shortDescription,
			startDate: helpEventResponse.startDate,
			endDate: helpEventResponse.endDate,
			fundName: helpEventResponse.fundName,
			address: helpEventResponse.address,
			phoneNumbers: helpEventResponse.phoneNumbers,
			contactLink: helpEventResponse.contactLink,
			imageNames: helpEventResponse.imageNames,
			description: helpEventResponse.description,
			organizationLink: helpEventResponse.organizationLink,
			peopleCount: helpEventResponse.peopleCount
		)
	}
}

// MARK: – Core Data Init
extension HelpEvent {
	init?(cdHelpEvent: CDHelpEvent) {
		guard
			let name = cdHelpEvent.name,
			let shortDescription = cdHelpEvent.shortDetail,
			let startDate = cdHelpEvent.startDate,
			let endDate = cdHelpEvent.endDate,
			let fundName = cdHelpEvent.fundName,
			let address = cdHelpEvent.address,
			let phoneNumbers = (cdHelpEvent.phoneNumbers?.array as? [CDPhoneNumber])?.map({ $0.phoneNumber ?? "" }),
			let contactLink = cdHelpEvent.contactLink,
			let imageNames = (cdHelpEvent.imageNames?.array as? [CDImageName])?.map({ $0.imageName ?? "" }),
			let description = cdHelpEvent.detail,
			let organizationLink = cdHelpEvent.organizationLink
		else {
			print("Error initializing HelpEvent from CDHelpEvent")
			
			return nil
		}
		
		self.init(
			id: Int(cdHelpEvent.id),
			name: name,
			shortDescription: shortDescription,
			startDate: startDate,
			endDate: endDate,
			fundName: fundName,
			address: address,
			phoneNumbers: phoneNumbers,
			contactLink: contactLink,
			imageNames: imageNames,
			description: description,
			organizationLink: organizationLink,
			peopleCount: Int(cdHelpEvent.peopleCount)
		)
	}
}

// MARK: – Realm Init
extension HelpEvent {
	init(rsHelpEvent: RSHelpEvent) {
		self.init(
			id: rsHelpEvent.id,
			name: rsHelpEvent.name,
			shortDescription: rsHelpEvent.shortDetail,
			startDate: rsHelpEvent.startDate as Date,
			endDate: rsHelpEvent.endDate as Date,
			fundName: rsHelpEvent.fundName,
			address: rsHelpEvent.address,
			phoneNumbers: Array(rsHelpEvent.phoneNumbers),
			contactLink: rsHelpEvent.contactLink,
			imageNames: Array(rsHelpEvent.imageNames),
			description: rsHelpEvent.detail,
			organizationLink: rsHelpEvent.organizationLink,
			peopleCount: rsHelpEvent.peopleCount
		)
	}
}
