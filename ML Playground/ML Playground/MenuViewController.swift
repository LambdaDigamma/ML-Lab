//
//  MenuViewController.swift
//  ML Playground
//
//  Created by Lennart Fischer on 02.11.23.
//

import UIKit
import SwiftUI

extension UICollectionReusableView {
    static var reuseIdentifier: String {
        return String(describing: Self.self)
    }
}

class MenuViewController: UIViewController, UICollectionViewDelegate {
    
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: setupCollectionViewLayout())
    var dataSource: UICollectionViewDiffableDataSource<MenuItemType, MenuItem>?
    var menuItems: [MenuItem]?

    // MARK: - UIViewController Lifecycle -
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        setupCollectionViewDataSource()
        populateCollectionViewDataSource()
        
    }
    
    // MARK: - Data Source -
    
    private func setupUI() {
        
        self.view.addSubview(collectionView)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        let constraints = [
            collectionView.topAnchor.constraint(equalTo: self.view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ]
        
        NSLayoutConstraint.activate(constraints)
        
        collectionView.delegate = self
        
    }
    
    private func setupCollectionViewLayout() -> UICollectionViewCompositionalLayout {
        
        let layout = UICollectionViewCompositionalLayout { _, environment -> NSCollectionLayoutSection? in
            
            /// Item spans the width and height of the group
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                  heightDimension: .fractionalHeight(1.0))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            
            /// Group spans the entire section and has an absolute height of 60
            
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                   heightDimension: .estimated(300))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                           subitems: [item])
            
            /// Set the section with the group
            let section = NSCollectionLayoutSection(group: group)
            
            
            /// Header size
            let headerFooterSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .absolute(60)
            )
            /// Header item
            let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
                layoutSize: headerFooterSize,
                elementKind: UICollectionView.elementKindSectionHeader,
                alignment: .top
            )
            sectionHeader.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 20, bottom: 0, trailing: 0)
            
            /// Set header item
            section.boundarySupplementaryItems = [sectionHeader]
            
            return section
            
        }
        
        return layout
        
    }
    
    private func setupCollectionViewDataSource() {
        
        let cellRegistration = UICollectionView.CellRegistration<UICollectionViewCell, MenuItem> { cell, indexPath, item in
            cell.contentConfiguration = UIHostingConfiguration {
                MenuItemCellView(menuItem: item)
            }
        }
        
        /// Create a datasource and connect it to  collection view `collectionView`
        dataSource = UICollectionViewDiffableDataSource<MenuItemType, MenuItem>(collectionView: collectionView) { (collectionView: UICollectionView, indexPath: IndexPath, item: MenuItem) -> UICollectionViewCell? in
            
            let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: item)
            
            return cell
        }
        
        let headerRegistration = UICollectionView.SupplementaryRegistration
        <UICollectionViewListCell>(elementKind: UICollectionView.elementKindSectionHeader) {
            [unowned self] (headerView, elementKind, indexPath) in
            
            // Obtain header item using index path
            let headerItem = self.dataSource?.snapshot().sectionIdentifiers[indexPath.section]
            
            // Configure header view content based on headerItem
            var configuration = headerView.defaultContentConfiguration()
            configuration.text = headerItem?.rawValue
            
            // Customize header appearance to make it more eye-catching
            configuration.textProperties.font = .boldSystemFont(ofSize: 16)
            configuration.textProperties.color = .systemBlue
            configuration.directionalLayoutMargins = .init(top: 20.0, leading: 0.0, bottom: 10.0, trailing: 0.0)
            
            // Apply the configuration to header view
            headerView.contentConfiguration = configuration
        }
        
        dataSource?.supplementaryViewProvider = { [unowned self]
            (collectionView, elementKind, indexPath) -> UICollectionReusableView? in
            
            if elementKind == UICollectionView.elementKindSectionHeader {
                
                // Dequeue header view
                return self.collectionView.dequeueConfiguredReusableSupplementary(
                    using: headerRegistration, for: indexPath)
                
            } else {
                
                // Dequeue footer view
                return nil
//                return self.collectionView.dequeueConfiguredReusableSupplementary(
//                    using: footerRegistration, for: indexPath)
            }
        }
        
    }
    
    private func populateCollectionViewDataSource() {
        
        let classifier: [MenuItem] = [
            .init(id: 1, text: "Animal Classifier", backgroundColor: .black, foregroundColor: .white)
        ]
        let objectDetectors: [MenuItem] = [
            .init(id: 1, text: "Fracture Detector", backgroundColor: .orange, foregroundColor: .white)
        ]
        
        var snapshot = NSDiffableDataSourceSnapshot<MenuItemType, MenuItem>()
        snapshot.appendSections([.classification, .objectDetector])
        snapshot.appendItems(classifier, toSection: .classification)
        snapshot.appendItems(objectDetectors, toSection: .objectDetector)
        dataSource?.apply(snapshot)
        
    }
    
    // MARK: - UICollectionViewDelegate
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard let menuItem = dataSource?.itemIdentifier(for: indexPath) else {
            return
        }
        
        let imageController = ImageClassificationViewController()
        
        self.navigationController?.pushViewController(imageController, animated: true)
        
    }
    
}
