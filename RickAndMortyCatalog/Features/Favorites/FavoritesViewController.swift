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
    
    @IBOutlet private weak var collectionView: UICollectionView! {
        didSet {
            collectionView.dataSource = self
            collectionView.delegate = self
        }
    }
    
    // MARK: - IBActions
    
    // MARK: - Properties
    
    var favoritedCharacters = [RMCharacter]() {
        didSet {
            collectionView.reloadData() 
        }
    }
    
    let minimumLineSpacing: CGFloat = 3
    
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
        guard favoritedCharacters.count > 0 else {
            collectionView.showEmptyView(message: "You have no favorites.")
            return 0
        }
        return favoritedCharacters.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FavoriteCharacterCell.identifier, for: indexPath) as? FavoriteCharacterCell else { return UICollectionViewCell() }
        cell.configure(with: favoritedCharacters[indexPath.item])
        return cell
    }
    
}

extension FavoritesViewController: UICollectionViewDelegate {
    
    // MARK: - Collection View Delegate
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "FavoriteCharacterSegue", sender: self)
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}

extension FavoritesViewController: UICollectionViewDelegateFlowLayout {
    
    // MARK: - Collection View Delegate Flow Layout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = (collectionView.bounds.width/3) - minimumLineSpacing
        return CGSize(width: size, height: size)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return minimumLineSpacing
    }
    
}
