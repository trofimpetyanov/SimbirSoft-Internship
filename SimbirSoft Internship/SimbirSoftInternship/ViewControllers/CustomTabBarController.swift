//
//  CustomTabBarController.swift
//  Block 1 – SimbirSoft Internship
//
//  Created by Trofim Petyanov on 28.06.2022.
//

import UIKit

final class CustomTabBarController: UITabBarController {
    private let helpButtonDiameter: CGFloat = 42
    
    private lazy var helpButton: UIButton = {
        let helpButton = UIButton()
        helpButton.layer.cornerRadius = helpButtonDiameter / 2
        helpButton.backgroundColor = UIColor.redColor
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
        helpButton.backgroundColor = UIColor.leaf
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
            helpButton.backgroundColor = UIColor.leaf
        } else {
            helpButton.backgroundColor = UIColor.redColor
        }
    }
}
