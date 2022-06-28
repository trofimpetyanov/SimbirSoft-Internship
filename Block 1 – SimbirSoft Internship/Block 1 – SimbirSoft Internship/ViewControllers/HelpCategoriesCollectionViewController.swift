//
//  HelpCategoriesCollectionViewController.swift
//  Block 1 – SimbirSoft Internship
//
//  Created by Trofim Petyanov on 28.06.2022.
//

import UIKit

private let reuseIdentifier = "helpCategoryCell"

class HelpCategoriesViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    @IBOutlet weak var collectionView: UICollectionView!
    
    private lazy var flowLayout: UICollectionViewFlowLayout = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        flowLayout.minimumInteritemSpacing = 8
        flowLayout.minimumLineSpacing = 8
        flowLayout.headerReferenceSize = CGSize(width: collectionView.frame.width, height: 50)
        flowLayout.itemSize = CGSize(width: collectionView.frame.width / 2 - 24, height: collectionView.frame.width / 2 - 24)
        flowLayout.sectionInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        return flowLayout
    }()
    
    struct Model {
        var helpCategories: [HelpCategory] {
            DataManager.shared.helpCategories
        }
    }
    
    var model = Model()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.collectionViewLayout = flowLayout
    }
    
    // MARK: UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return DataManager.shared.helpCategories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: reuseIdentifier,
            for: indexPath) as? HelpCategoryCollectionViewCell else { return UICollectionViewCell() }
        let helpCategory = model.helpCategories[indexPath.row]
        
        cell.configureCell(with: helpCategory)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            guard let headerView = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: "helpCategoriesHeader",
                for: indexPath) as? HelpCategoriesCollectionHeaderView else { return UICollectionViewCell() }
            headerView.titleLabel.text = "Выберите категорию помощи"
            return headerView
        default:
            fatalError("Unexpected element kind")
        }
    }
}
