//
//  EventCollectionViewCell.swift
//  Block 1 – SimbirSoft Internship
//
//  Created by Trofim Petyanov on 11.07.2022.
//

import UIKit
import SnapKit

class EventCollectionViewCell: UICollectionViewCell {
    static let cellID = "eventCell"
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        
        imageView.contentMode = .scaleAspectFill
        
        return imageView
    }()
    
    lazy var shadowImageView: UIImageView = {
        let imageView = UIImageView()
        
        imageView.image = UIImage(named: "shadow")

        return imageView
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        
        label.numberOfLines = 0
        label.font = UIFont(name: "OfficinaSansExtraBoldSCC", size: 21)
        label.textAlignment = .center
        label.textColor = UIColor.blueGrey
        
        return label
    }()
    
    lazy var separatorImageView: UIImageView = {
        let image = UIImage(named: "separator")
        let imageView = UIImageView()
        
        imageView.contentMode = .scaleAspectFit
        imageView.image = image
        
        return imageView
    }()
    
    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = UIColor.darkSlateBlue
        
        return label
    }()
    
    lazy var calendarImageView: UIImageView = {
        let image = UIImage(named: "calendar")
        let imageView = UIImageView(image: image)
        
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    lazy var dateLabel: UILabel = {
        let label = UILabel()
        
        label.font = UIFont(name: "OfficinaSansExtraBoldSCC", size: 11)
        label.textAlignment = .center
        label.textColor = UIColor.white
        
        return label
    }()
    
    lazy var dateStackView: UIStackView = {
        let stackView = UIStackView()
        
        stackView.axis = .horizontal
        stackView.alignment = .center
        
        stackView.addArrangedSubview(calendarImageView)
        stackView.addArrangedSubview(dateLabel)
        
        return stackView
    }()
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.spacing = 4
        
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(separatorImageView)
        stackView.addArrangedSubview(descriptionLabel)
        
        return stackView
    }()
    
    override func layoutSubviews() {
        backgroundColor = .white
        layer.cornerRadius = 8
        
        self.addSubview(imageView)
        self.addSubview(shadowImageView)
        self.addSubview(stackView)
        
        imageView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(10)
            make.leading.trailing.equalToSuperview().inset(8)
        }
        
        shadowImageView.snp.makeConstraints { make in
            make.leading.trailing.equalTo(imageView)
            make.bottom.equalTo(imageView).inset(-4)
        }
        
        separatorImageView.snp.makeConstraints { make in
            make.height.equalTo(20)
        }
        
        stackView.snp.makeConstraints { make in
            make.top.equalTo(separatorImageView.snp.bottomMargin)
            make.leading.trailing.equalToSuperview().inset(8)
        }
    }
}
