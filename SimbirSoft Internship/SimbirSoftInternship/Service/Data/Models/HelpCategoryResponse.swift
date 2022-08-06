//
//  HelpCategoryResponse.swift
//  SimbirSoftInternship
//
//  Created by Trofim Petyanov on 05.08.2022.
//

import Foundation

struct HelpCategoryResponse {
	let id: Int
	let name: String
	let imageName: String
	let eventIds: [Int]
}

extension HelpCategoryResponse: Codable { }
