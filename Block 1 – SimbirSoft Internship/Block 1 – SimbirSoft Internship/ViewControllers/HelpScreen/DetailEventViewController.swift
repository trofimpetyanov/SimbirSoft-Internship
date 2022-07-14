//
//  DetailEventViewController.swift
//  Block 1 – SimbirSoft Internship
//
//  Created by Trofim Petyanov on 14.07.2022.
//

import UIKit

class DetailEventViewController: UIViewController {
   
    var helpEvent: HelpEvent
    
    init?(coder: NSCoder, helpEvent: HelpEvent) {
        self.helpEvent = helpEvent
        
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBarController?.tabBar.isHidden = true
    }
}
