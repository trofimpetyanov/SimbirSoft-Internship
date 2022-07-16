//
//  HelpCategory.swift
//  Block 1 – SimbirSoft Internship
//
//  Created by Trofim Petyanov on 28.06.2022.
//

import Foundation

struct HelpCategory: Codable {
    let id: Int
    let name: String
    let imageName: String
    let eventsIds: [Int]
}
