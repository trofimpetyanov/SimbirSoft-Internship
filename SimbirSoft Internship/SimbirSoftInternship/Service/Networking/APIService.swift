//
//  APIService.swift
//  SimbirSoftInternship
//
//  Created by Trofim Petyanov on 06.08.2022.
//

import Foundation

struct HelpCategoriesRequest: APIRequest {
	typealias Response = [HelpCategoryResponse]
	
	var path: String { "/helpCategories" }
}

struct HelpEventsRequest: APIRequest {
	typealias Response = [HelpEventResponse]
	
	var path: String { "/helpEvents" }
}
