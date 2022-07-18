//
//  EventCollectionViewCell.swift
//  Block 1 – SimbirSoft Internship
//
//  Created by Trofim Petyanov on 11.07.2022.
//

import UIKit
import SnapKit

final class EventCollectionViewCell: UICollectionViewCell {
    static let cellID = "eventCell"
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        
        imageView.contentMode = .scaleAspectFill
        
        return imageView
    }()
    
    private lazy var shadowImageView: UIImageView = {
        let imageView = UIImageView()
        
        imageView.image = UIImage(named: "shadow")

        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        
        label.numberOfLines = 0
        label.font = UIFont(name: "OfficinaSansExtraBoldSCC", size: 21)
        label.textAlignment = .center
        label.textColor = UIColor.blueGray
        
        return label
    }()
    
    private lazy var separatorImageView: UIImageView = {
        let image = UIImage(named: "heartSeparator")
        let imageView = UIImageView()
        
        imageView.contentMode = .scaleAspectFit
        imageView.image = image
        
        return imageView
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = UIColor.darkSlateBlue
        
        return label
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.spacing = 8
        
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(separatorImageView)
        stackView.addArrangedSubview(descriptionLabel)
        
        return stackView
    }()
    
    private lazy var calendarImageView: UIImageView = {
        let image = UIImage(named: "calendar")
        let imageView = UIImageView(image: image)
        
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        
        label.font = UIFont.systemFont(ofSize: 11)
        label.textAlignment = .left
        label.textColor = UIColor.white
        
        return label
    }()
    
    private lazy var dateStackView: UIStackView = {
        let stackView = UIStackView()
        
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 8
        
        stackView.addArrangedSubview(calendarImageView)
        stackView.addArrangedSubview(dateLabel)
        
        return stackView
    }()
    
    private lazy var dateView: UIView = {
        let view = UIView()
        view.backgroundColor = .leaf
        
        view.addSubview(dateStackView)
        
        dateStackView.snp.remakeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
        
        return view
    }()
    
    override func layoutSubviews() {
        backgroundColor = .white
        layer.cornerRadius = 8
        
        self.addSubview(imageView)
        self.addSubview(shadowImageView)
        self.addSubview(stackView)
        self.addSubview(dateView)
        
        imageView.snp.remakeConstraints {
            $0.top.equalToSuperview().inset(8)
            $0.leading.trailing.equalToSuperview().inset(4)
        }
        
        shadowImageView.snp.remakeConstraints {
            $0.leading.trailing.equalToSuperview().inset(4)
            $0.bottom.equalTo(imageView).offset(8)
        }
        
        stackView.snp.remakeConstraints {
            $0.top.equalTo(imageView.snp.bottom)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        
        dateView.snp.remakeConstraints {
            $0.top.equalTo(stackView.snp.bottom).offset(8)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    func configure(with helpEvent: HelpEvent) {
        imageView.image = UIImage(named: helpEvent.imageNames[0])
        titleLabel.text = helpEvent.name
        descriptionLabel.text = helpEvent.shortDescription
        
        if let dateDifference = Calendar.current.dateComponents([.day], from: helpEvent.startDate, to: helpEvent.endDate).day {
            let dateRange = DateFormatter.dateRange(startDate: helpEvent.startDate, endDate: helpEvent.endDate, style: .ddMM)
                                                    
            dateLabel.text = "Осталось \(dateDifference) дней (\(dateRange))"
        }
    }
}
