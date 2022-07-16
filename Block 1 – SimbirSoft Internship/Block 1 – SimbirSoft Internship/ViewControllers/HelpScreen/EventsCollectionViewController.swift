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
        self.helpEvents = DataManager.shared.helpEvents.filter { helpCategory.eventsIds.contains($0.id) }
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let helpCategory: HelpCategory
    let helpEvents: [HelpEvent]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = helpCategory.name
        view.backgroundColor = .gray
        
        collectionView.collectionViewLayout = flowLayout
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        tabBarController?.tabBar.isHidden = false
    }
    
    // MARK: UICollectionViewDataSource
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return helpEvents.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: EventCollectionViewCell.cellID,
            for: indexPath) as? EventCollectionViewCell
        else { return UICollectionViewCell() }
    
        let event = helpEvents[indexPath.item]
    
        cell.imageView.image = UIImage(named: event.imageNames[0])
        cell.titleLabel.text = event.name
        cell.descriptionLabel.text = event.shortDescription
        cell.dateLabel.text = "\(event.startDate)"
        
        return cell
    }
    
    @IBSegueAction func showDetailEvent(_ coder: NSCoder, sender: Any?) -> DetailEventViewController? {
        tabBarController?.tabBar.isHidden = true
        
        guard let cell = sender as? EventCollectionViewCell, let indexPath = collectionView.indexPath(for: cell)
        else { return DetailEventViewController(coder: coder) }
        
        return DetailEventViewController(coder: coder, helpEvent: helpEvents[indexPath.row])
    }
}
