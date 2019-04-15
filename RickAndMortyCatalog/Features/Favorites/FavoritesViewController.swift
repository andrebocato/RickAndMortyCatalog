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
        // @TODO: change collection view content for each segment
    }
    
    // MARK: - Properties
    
    var favoritedCharacters = [RMCharacter]() {
        didSet {
            collectionView.reloadData() 
        }
    }
    var favoritedLocations = [RMLocation]() {
        didSet {
            collectionView.reloadData()
        }
    }
    
    // MARK: - Lifecycle
    
    // MARK: - Navigation
    
    // MARK: - Functions
    
    // MARK: - Configuration
    
    // MARK: - Helper Functions
    
}

// MARK: - Extensions

extension FavoritesViewController: UICollectionViewDataSource {
    
    // MARK: - Collection View Data Source
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            guard favoritedCharacters.count > 0 else {
                collectionView.showEmptyView(message: "No favorite characters to show")
                return 0
            }
            return favoritedCharacters.count
            
        case 1:
            guard favoritedLocations.count > 0 else {
                collectionView.showEmptyView(message: "No favorite locations to show")
                return 0
            }
            return favoritedLocations.count
            
        default: return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FavoriteCell", for: indexPath) as? FavoriteCell else { return UICollectionViewCell() }
        // @TODO: configure cell
        return cell
    }
    
}

extension FavoritesViewController: UICollectionViewDelegate {
    
    // MARK: - Collection View Delegate
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "LocationDetailSegue", sender: self)
    }
}
