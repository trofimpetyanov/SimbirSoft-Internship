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
        HelpCategory(name: "Дети", imageName: "children"),
        HelpCategory(name: "Взрослые", imageName: "adults"),
        HelpCategory(name: "Пожилые", imageName: "seniors"),
        HelpCategory(name: "Животные", imageName: "animals"),
        HelpCategory(name: "Мероприятия", imageName: "events")
    ]
    
    private init() { }
}
