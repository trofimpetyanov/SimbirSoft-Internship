//
//  HelpCategoryCollectionViewCell.swift
//  Block 1 – SimbirSoft Internship
//
//  Created by Trofim Petyanov on 28.06.2022.
//

import UIKit

class HelpCategoryCollectionViewCell: UICollectionViewCell {
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    
    func configureCell(with helpCategory: HelpCategory) {
        imageView.image = UIImage(named: helpCategory.imageName)
        nameLabel.text = helpCategory.name
    }
}
