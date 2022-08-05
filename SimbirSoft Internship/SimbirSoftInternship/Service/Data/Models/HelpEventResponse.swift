//
//  HelpEventResponse.swift
//  SimbirSoftInternship
//
//  Created by Trofim Petyanov on 05.08.2022.
//

import Foundation

struct HelpEventResponse {
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

extension HelpEventResponse: Codable { }
