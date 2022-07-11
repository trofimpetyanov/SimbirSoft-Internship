//
//  AppearanceConfigurator.swift
//  Block 1 – SimbirSoft Internship
//
//  Created by Trofim Petyanov on 30.06.2022.
//

import UIKit

enum AppearanceConfigurator {
    static func configureNavigationBar() {
        let titleTextAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.white,
            .font: UIFont(name: "OfficinaSansExtraBoldSCC", size: 21)!
        ]
        
        let buttonTextAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.white,
            .font: UIFont(name: "OfficinaSansExtraBoldSCC", size: 18)!
        ]
    
        UINavigationBar.appearance().tintColor = UIColor.white
        
        if #available(iOS 13.0, *) {
            let barButtonItemApperanace = UIBarButtonItemAppearance()
            barButtonItemApperanace.normal.titleTextAttributes = buttonTextAttributes
            
            let navigationBarAppearance = UINavigationBarAppearance()
            navigationBarAppearance.configureWithOpaqueBackground()
            navigationBarAppearance.backgroundColor = UIColor.greenColor
            navigationBarAppearance.titleTextAttributes = titleTextAttributes
            navigationBarAppearance.buttonAppearance = barButtonItemApperanace
            
            UINavigationBar.appearance().standardAppearance = navigationBarAppearance
            UINavigationBar.appearance().scrollEdgeAppearance = UINavigationBar.appearance().standardAppearance
        } else {
            UINavigationBar.appearance().barTintColor = UIColor.greenColor
            UINavigationBar.appearance().titleTextAttributes = titleTextAttributes
            UIBarButtonItem.appearance().setTitleTextAttributes(buttonTextAttributes, for: .normal)
        }
    }
}
