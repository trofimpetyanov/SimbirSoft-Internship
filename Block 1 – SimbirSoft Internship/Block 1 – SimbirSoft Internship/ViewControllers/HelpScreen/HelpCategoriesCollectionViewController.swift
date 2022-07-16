//
//  HelpCategoriesCollectionViewController.swift
//  Block 1 – SimbirSoft Internship
//
//  Created by Trofim Petyanov on 28.06.2022.
//

import UIKit

class HelpCategoriesViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    @IBOutlet weak var collectionView: UICollectionView!
    
    private lazy var flowLayout: UICollectionViewFlowLayout = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        flowLayout.minimumInteritemSpacing = 8
        flowLayout.minimumLineSpacing = 8
        flowLayout.headerReferenceSize = CGSize(width: collectionView.frame.width, height: 50)
        flowLayout.itemSize = CGSize(width: (UIScreen.main.bounds.width - 24) / 2, height: (UIScreen.main.bounds.width - 24) / 2)
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 8, bottom: 8, right: 8)
        return flowLayout
    }()
    
    let helpCategories: [HelpCategory] = DataManager.shared.helpCategories
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.collectionViewLayout = flowLayout
        collectionView.alwaysBounceVertical = true
    }
    
    // MARK: UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return helpCategories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: HelpCategoryCollectionViewCell.cellID,
            for: indexPath) as? HelpCategoryCollectionViewCell else { return UICollectionViewCell() }
        let helpCategory = helpCategories[indexPath.row]
        
        cell.configureCell(with: helpCategory)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            guard let headerView = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: HelpCategoriesCollectionHeaderView.headerID,
                for: indexPath) as? HelpCategoriesCollectionHeaderView else { return UICollectionViewCell() }
            headerView.titleLabel.text = "Выберите категорию помощи"
            return headerView
        default:
            fatalError("Unexpected element kind")
        }
    }
    
    @IBSegueAction func showEvents(_ coder: NSCoder, sender: Any?) -> EventsCollectionViewController? {
        guard let cell = sender as? HelpCategoryCollectionViewCell, let indexPath = collectionView.indexPath(for: cell)
        else { return EventsCollectionViewController(coder: coder) }
        
        return EventsCollectionViewController(coder: coder, helpEvents: helpCategories[indexPath.item].events)
    }
}
