//
//  FavoritesViewController.swift
//  RickAndMortyCatalog
//
//  Created by Andre Sanches Bocato on 09/04/19.
//  Copyright © 2019 Andre Sanches Bocato. All rights reserved.
//

import UIKit

class FavoritesViewController: UIViewController {

    // MARK: - IBOutlets
    
    @IBOutlet private weak var segmentedControl: UISegmentedControl!
    @IBOutlet private weak var settingsBarButtonItem: UIBarButtonItem!
    @IBOutlet private weak var collectionView: UICollectionView! {
        didSet {
            collectionView.dataSource = self
            collectionView.delegate = self
        }
    }
    
    // MARK: - IBActions
    
    @IBAction func settingsBarButtonItemDidReceiveTouchUpInside(_ sender: Any) {
        performSegue(withIdentifier: "SettingsSegue", sender: self)
    }
    
    @IBAction func segmentedControlValueChanged(_ sender: Any) {
        collectionView.hideEmptyView()
        collectionView.reloadData()
        // @TODO: change collection view content for each segment
    }
    
    // MARK: - Properties
    
    var favoritedCharacters = [RMCharacter]() {
        didSet {
            collectionView.reloadData() 
        }
    }
    
    // MARK: - Lifecycle
    
    // MARK: - Navigation
    
    // MARK: - Functions
    
    // MARK: - Configuration Functions
    
    // MARK: - Helper Functions
    
}

// MARK: - Extensions

extension FavoritesViewController: UICollectionViewDataSource {
    
    // MARK: - Collection View Data Source
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            guard favoritedCharacters.count > 0 else {
                collectionView.showEmptyView(message: "No favorite characters to show.")
                return 0
            }
            return favoritedCharacters.count
            
        case 1:
            guard favoritedLocations.count > 0 else {
                collectionView.showEmptyView(message: "No favorite locations to show.")
                return 0
            }
            return favoritedLocations.count
            
        default: return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FavoriteCell.identifier, for: indexPath) as? FavoriteCell else { return UICollectionViewCell() }
        
//        cell.configure()
        
        return cell
    }
    
}

extension FavoritesViewController: UICollectionViewDelegate {
    
    // MARK: - Collection View Delegate
    
    // @TODO: implement
}

extension FavoritesViewController: UICollectionViewDelegateFlowLayout {
    
    // MARK: - Collection View Delegate Flow Layout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = (collectionView.bounds.width/3) - 3
        return CGSize(width: size, height: size)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 3 // @TODO: magic number
    }
    
}
