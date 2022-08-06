//
//  DetailEventViewController.swift
//  SimbirSoftInternship
//
//  Created by Trofim Petyanov on 14.07.2022.
//

import UIKit

final class DetailEventViewController: UIViewController {
    @IBOutlet var eventNameLabel: UILabel!
    @IBOutlet var dateRangeStackView: UIStackView!
    @IBOutlet var dateRangeLabel: UILabel!
    @IBOutlet var fundNameLabel: UILabel!
    
    @IBOutlet var addressLabel: UILabel!
    @IBOutlet var phoneNumberLabel: UILabel!
    @IBOutlet var mailStackView: UIStackView!
    @IBOutlet var mailTextView: UITextView!
    
    @IBOutlet var bigImageView: UIImageView!
    @IBOutlet var smallImageViewTop: UIImageView!
    @IBOutlet var smallImageViewBottom: UIImageView!
    
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var linkTextView: UITextView!
    
    @IBOutlet var countLabel: UILabel!
    
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
        
        configureUI()
    }
    
    private func configureUI() {
        title = helpEvent.name
        
        eventNameLabel.text = helpEvent.name
        
        // Date Range Label
        if let dateDifference = Calendar.current.dateComponents([.day], from: helpEvent.startDate, to: helpEvent.endDate).day {
            let dateRange = DateFormatter.dateRange(startDate: helpEvent.startDate, endDate: helpEvent.endDate, style: .ddMM)
                                                    
            dateRangeLabel.text = "Осталось \(dateDifference) дней (\(dateRange))"
            
            dateRangeStackView.isHidden = false
        } else {
            dateRangeStackView.isHidden = true
        }
        
        fundNameLabel.text = helpEvent.fundName
        addressLabel.text = helpEvent.address
        phoneNumberLabel.text = helpEvent.phoneNumbers.joined(separator: "\n")
        
        // Contact us TextView
        if let url = URL(string: helpEvent.contactLink), UIApplication.shared.canOpenURL(url) {
            let plainAttributedString = NSMutableAttributedString(string: "У вас есть вопросы? ", attributes: [
                .foregroundColor: UIColor.charcoalGray,
                .font: UIFont.systemFont(ofSize: 15)
            ])
            let linkAttributedString = NSMutableAttributedString(
                string: "Напишите нам",
                attributes: [
                    .link: helpEvent.contactLink,
                    .foregroundColor: UIColor.green,
                    .font: UIFont.systemFont(ofSize: 15),
                    .underlineStyle: NSUnderlineStyle.single.rawValue
                ])
            
            let fullAttributedString = NSMutableAttributedString()
            fullAttributedString.append(plainAttributedString)
            fullAttributedString.append(linkAttributedString)
            
            mailTextView.textContainerInset = UIEdgeInsets.zero
            mailTextView.attributedText = fullAttributedString
            
            mailStackView.isHidden = false
        } else {
            mailStackView.isHidden = true
        }
    
        // Images
        bigImageView.image = UIImage(named: helpEvent.imageNames[0])
        smallImageViewTop.image = UIImage(named: helpEvent.imageNames[1])
        smallImageViewBottom.image = UIImage(named: helpEvent.imageNames[2])
        
        descriptionLabel.text = helpEvent.description
        
        // Organization link TextView
        if let url = URL(string: helpEvent.organizationLink), UIApplication.shared.canOpenURL(url) {
            let linkAttributedString = NSMutableAttributedString(
                string: "Перейти на сайт организации",
                attributes: [
                    .link: helpEvent.organizationLink,
                    .foregroundColor: UIColor.green,
                    .font: UIFont.systemFont(ofSize: 15),
                    .underlineStyle: NSUnderlineStyle.single.rawValue
                ])
            
            linkTextView.textContainerInset = UIEdgeInsets.zero
            linkTextView.attributedText = linkAttributedString
            
            linkTextView.isHidden = false
        } else {
            linkTextView.isHidden = true
        }
        
        countLabel.text = "+\(helpEvent.peopleCount - 5)"
    }
    
    @IBAction func shareButtonTapped(_ sender: UIBarButtonItem) {
        let eventName = helpEvent.name
        let dateRange = DateFormatter.dateRange(startDate: helpEvent.startDate, endDate: helpEvent.endDate, style: .ddMM)
        let address = helpEvent.address
        let message = "\(eventName)\n\n\(dateRange)\n\(address)"
        var activityItems: [Any] = [message]
        
        if let image = UIImage(named: helpEvent.imageNames[0]) {
            activityItems.append(image)
        }
        
        let activityController = UIActivityViewController(activityItems: activityItems, applicationActivities: nil)
        
        present(activityController, animated: true)
    }
}
