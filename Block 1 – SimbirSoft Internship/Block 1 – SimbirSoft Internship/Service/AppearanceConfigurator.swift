//
//  AppearanceConfigurator.swift
//  Block 1 – SimbirSoft Internship
//
//  Created by Trofim Petyanov on 30.06.2022.
//

import UIKit

enum AppearanceConfigurator {
    static func configure() {
        let appearance = UINavigationBar.appearance()
        appearance.backgroundColor = UIColor.greenColor
        appearance.tintColor = .white
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
    }
}
