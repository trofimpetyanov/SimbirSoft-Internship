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
        HelpCategory(id: 0, name: "Дети", imageName: "children", events: [
            HelpEvent(
                id: 0,
                name: "Спонсоры отремонтируют школу-интернат",
                description: "Дубовская школа-интернат для детей с ограниченными возможностями здоровья стала первой в области…",
                imageName: "child",
                startDate: Date(),
                endDate: Date()),
            HelpEvent(
                id: 1,
                name: "Конкурс по вокальному пению в детском доме №6",
                description: "Дубовская школа-интернат для детей с ограниченными возможностями здоровья стала первой в области …",
                imageName: "fatherAndSon",
                startDate: Date(),
                endDate: Date())
        ]),
        HelpCategory(id: 1, name: "Взрослые", imageName: "adults", events: []),
        HelpCategory(id: 2, name: "Пожилые", imageName: "seniors", events: []),
        HelpCategory(id: 3, name: "Животные", imageName: "animals", events: []),
        HelpCategory(id: 4, name: "Мероприятия", imageName: "events", events: [])
    ]
    
    private init() { }
}
