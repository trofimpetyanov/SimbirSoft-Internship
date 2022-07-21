//
//  EventsCollectionViewController.swift
//  Block 1 – SimbirSoft Internship
//
//  Created by Trofim Petyanov on 11.07.2022.
//

import UIKit

final class EventsCollectionViewController: UICollectionViewController {
    
    private lazy var flowLayout: UICollectionViewFlowLayout = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        flowLayout.minimumInteritemSpacing = 8
        flowLayout.minimumLineSpacing = 8
        flowLayout.itemSize = CGSize(width: UIScreen.main.bounds.width - 16, height: 420)
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
        
        collectionView.backgroundColor = .backgroundGray
        collectionView.collectionViewLayout = flowLayout
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
        let helpEvent = helpEvents[indexPath.item]
    
        cell.configure(with: helpEvent)
        
        return cell
    }
    
    @IBSegueAction func showDetailEvent(_ coder: NSCoder, sender: Any?) -> DetailEventViewController? {
        guard let cell = sender as? EventCollectionViewCell, let indexPath = collectionView.indexPath(for: cell)
        else { return DetailEventViewController(coder: coder) }
        
        return DetailEventViewController(coder: coder, helpEvent: helpEvents[indexPath.row])
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let detailEventViewController = segue.destination as? DetailEventViewController {
            detailEventViewController.hidesBottomBarWhenPushed = true
        }
    }
}
