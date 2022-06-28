//
//  CustomTabBarController.swift
//  Block 1 – SimbirSoft Internship
//
//  Created by Trofim Petyanov on 28.06.2022.
//

import UIKit

class CustomTabBarController: UITabBarController {
    private let helpButtonDiameter: CGFloat = 42
    
    private let redColor = UIColor(red: 254 / 255, green: 116 / 255, blue: 96 / 255, alpha: 1)
    private let greenColor = UIColor(red: 101 / 255, green: 166 / 255, blue: 54 / 255, alpha: 1)
    
    private lazy var helpButton: UIButton = {
        let helpButton = UIButton()
        helpButton.layer.cornerRadius = helpButtonDiameter / 2
        helpButton.backgroundColor = redColor
        helpButton.translatesAutoresizingMaskIntoConstraints = false
        helpButton.addTarget(self, action: #selector(helpButtonTapped), for: .touchUpInside)
        return helpButton
    }()
    
    private lazy var heartImageView: UIImageView = {
        let heartImageView = UIImageView()
        heartImageView.image = UIImage(named: "heart.fill")
        heartImageView.tintColor = .white
        heartImageView.translatesAutoresizingMaskIntoConstraints = false
        return heartImageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupHelpButton()
    }
    
    @objc func helpButtonTapped() {
        selectedIndex = 2
        helpButton.backgroundColor = greenColor
    }
    
    private func setupHelpButton() {
        tabBar.addSubview(helpButton)
        helpButton.addSubview(heartImageView)
        
        NSLayoutConstraint.activate([
            helpButton.heightAnchor.constraint(equalToConstant: helpButtonDiameter),
            helpButton.widthAnchor.constraint(equalToConstant: helpButtonDiameter),
            
            helpButton.centerXAnchor.constraint(equalTo: tabBar.centerXAnchor),
            helpButton.topAnchor.constraint(equalTo: tabBar.topAnchor, constant: -10)
        ])
        
        NSLayoutConstraint.activate([
            heartImageView.heightAnchor.constraint(equalToConstant: 16),
            heartImageView.widthAnchor.constraint(equalToConstant: 18),
            
            heartImageView.centerXAnchor.constraint(equalTo: helpButton.centerXAnchor),
            heartImageView.centerYAnchor.constraint(equalTo: helpButton.centerYAnchor)
        ])
    }
}

extension CustomTabBarController: UITabBarControllerDelegate {
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        let selectedIndex = self.tabBar.items?.firstIndex(of: item)
        
        if selectedIndex == 2 {
            helpButton.backgroundColor = greenColor
        } else {
            helpButton.backgroundColor = redColor
        }
    }
}
