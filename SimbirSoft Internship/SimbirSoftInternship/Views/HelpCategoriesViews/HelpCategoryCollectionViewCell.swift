//
//  HelpCategoryCollectionViewCell.swift
//  SimbirSoftInternship
//
//  Created by Trofim Petyanov on 28.06.2022.
//

import UIKit

final class HelpCategoryCollectionViewCell: UICollectionViewCell {
    static let cellID = "helpCategoryCell"
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    
    func configureCell(with helpCategory: HelpCategory) {
        imageView.image = UIImage(named: helpCategory.imageName)
        nameLabel.text = helpCategory.name
    }
}
