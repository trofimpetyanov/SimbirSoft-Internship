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
                shortDescription: "Дубовская школа-интернат для детей с ограниченными возможностями здоровья стала первой в области …",
                startDate: Date(),
                endDate: Calendar.current.date(byAdding: .day, value: 5, to: Date()) ?? Date(),
                fundName: "Благотворительный фонд «Счастливый Мир»",
                address: "Санкт-Петербург, Кирочная улица, д. 50А, каб. 208",
                phoneNumbers: ["+7 (937) 037 37-73", "+7 (937) 016 16-16"],
                contactLink: "https://www.apple.com",
                imageNames: ["child", "twoPeople", "leg"],
                // swiftlint:disable line_length
                description: "Участники и болельщики смогли весело и активно провести время на «Петербургском благотворительном марафоне» и при этом финансово поучаствовать в помощи детям. При этом финансово поучаствовать в помощи детям. При этом финансово поучаствовать в помощи детям.",
                // swiftlint:enable line_length
                organizationLink: "https://www.apple.com",
                peopleCount: 107
            ),
            HelpEvent(
                id: 1,
                name: "Конкурс по вокальному пению в детском доме №6",
                shortDescription: "Дубовская школа-интернат для детей с ограниченными возможностями здоровья стала первой в области …",
                startDate: Date(),
                endDate: Calendar.current.date(byAdding: .day, value: 2, to: Date()) ?? Date(),
                fundName: "Благотворительный фонд «Счастливый Мир»",
                address: "Санкт-Петербург, Кирочная улица, д. 50А, каб. 208",
                phoneNumbers: ["+7 (937) 037 37-73", "+7 (937) 016 16-16"],
                contactLink: "https://www.apple.com",
                imageNames: ["fatherAndSon", "twoPeople", "leg"],
                // swiftlint:disable line_length
                description: "Участники и болельщики смогли весело и активно провести время на «Петербургском благотворительном марафоне» и при этом финансово поучаствовать в помощи детям. При этом финансово поучаствовать в помощи детям. При этом финансово поучаствовать в помощи детям.",
                // swiftlint:enable line_length
                organizationLink: "https://www.apple.com",
                peopleCount: 128
            )
        ]),
        HelpCategory(id: 1, name: "Взрослые", imageName: "adults", events: []),
        HelpCategory(id: 2, name: "Пожилые", imageName: "seniors", events: []),
        HelpCategory(id: 3, name: "Животные", imageName: "animals", events: []),
        HelpCategory(id: 4, name: "Мероприятия", imageName: "events", events: [])
    ]
    
    private init() { }
}
