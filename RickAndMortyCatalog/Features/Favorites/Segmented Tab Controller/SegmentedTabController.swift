//
//  SegmentedTabController.swift
//  RickAndMortyCatalog
//
//  Created by Andre Sanches Bocato on 22/05/19.
//  Copyright © 2019 Andre Sanches Bocato. All rights reserved.
//

import UIKit

class SegmentedTabController: UIViewController {
    
    // MARK: - IBOutlets

    @IBOutlet private weak var horizontalCollectionView: UICollectionView! {
        didSet {
            horizontalCollectionView.delegate = self
            horizontalCollectionView.dataSource = self
        }
    }
    
    // MARK: - Eums
    
    enum Titles: Int, CaseIterable {
        case all
        case alive
        case dead
        case unknown
        
        var stringValue: String {
            switch self {
            case .all: return "All"
            case .alive: return "Alive"
            case .dead: return "Dead"
            case .unknown: return "Unknown"
            }
        }
    }
    
}

// MARK: - Extensions

extension SegmentedTabController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Titles.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let title = Titles(rawValue: indexPath.item)?.stringValue else { return UICollectionViewCell() }
        return horizontalCollectionView.dequeueReusableCell(ofClass: FavoriteFilterCell.self, for: indexPath).configured(withTitle: title)
    }
    
}

extension SegmentedTabController: UICollectionViewDelegate {
    // @TODO: when tapped, filters depending
}

extension SegmentedTabController: UICollectionViewDelegateFlowLayout {
    
    
    
}
