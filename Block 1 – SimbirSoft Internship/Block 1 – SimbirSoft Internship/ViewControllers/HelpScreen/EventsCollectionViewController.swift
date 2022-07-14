//
//  EventsCollectionViewController.swift
//  Block 1 – SimbirSoft Internship
//
//  Created by Trofim Petyanov on 11.07.2022.
//

import UIKit

class EventsCollectionViewController: UICollectionViewController {
    
    private lazy var flowLayout: UICollectionViewFlowLayout = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        flowLayout.minimumInteritemSpacing = 8
        flowLayout.minimumLineSpacing = 8
        flowLayout.itemSize = CGSize(width: UIScreen.main.bounds.width - 16, height: 400)
        flowLayout.sectionInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        return flowLayout
    }()
    
    init?(coder: NSCoder, helpCategory: HelpCategory) {
        self.helpCategory = helpCategory
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let helpCategory: HelpCategory

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .gray
        
        collectionView.collectionViewLayout = flowLayout
    }

    // MARK: UICollectionViewDataSource
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return helpCategory.events.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EventCollectionViewCell.cellID, for: indexPath) as? EventCollectionViewCell
        else { return UICollectionViewCell() }
    
        let event = helpCategory.events[indexPath.item]
    
        cell.imageView.image = UIImage(named: event.imageName)
        cell.titleLabel.text = event.name
        cell.descriptionLabel.text = event.description
        cell.dateLabel.text = "\(event.startDate)"
        
        return cell
    }
}
