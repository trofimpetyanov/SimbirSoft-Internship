//
//  DataManager.swift
//  Block 1 – SimbirSoft Internship
//
//  Created by Trofim Petyanov on 28.06.2022.
//

import Foundation

struct DataManager {
    static let shared = DataManager()
    
    var helpCategories = [
        HelpCategory(name: "Дети", imageName: "children.pdf"),
        HelpCategory(name: "Взрослые", imageName: "adults.pdf"),
        HelpCategory(name: "Пожилые", imageName: "seniors.pdf"),
        HelpCategory(name: "Животные", imageName: "animals.pdf"),
        HelpCategory(name: "Мероприятия", imageName: "events.pdf")
    ]
    
    private init() { }
}
