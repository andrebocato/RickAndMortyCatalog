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
    var selectedCharacter: RMCharacter!
    
    let minimumSpacing: CGFloat = 2
    
    // MARK: - Lifecycle
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destination = segue.destination as? CharacterDetailViewController, segue.destination is CharacterDetailViewController else { return }
        
        if segue.identifier == "FavoriteCharacterSegue" {
            destination.character = selectedCharacter
        }
    }
    
    // MARK: - Functions
    
    // MARK: - Configuration Functions
    
    // MARK: - Helper Functions
    
}

// MARK: - Extensions

extension FavoritesViewController: UICollectionViewDataSource {
    
    // MARK: - Collection View Data Source
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        guard favoritedCharacters.count > 0 else {
//            collectionView.showEmptyView(message: "You have no favorites.")
//            return 0
//        }
        return 5//favoritedCharacters.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FavoriteCell.identifier, for: indexPath) as? FavoriteCell else { return UICollectionViewCell() }
        cell.configure(/*with: favoritedCharacters[indexPath.item]*/)
        return cell
    }
    
}

extension FavoritesViewController: UICollectionViewDelegate {
    
    // MARK: - Collection View Delegate
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedCharacter = favoritedCharacters[indexPath.item]
        performSegue(withIdentifier: "FavoriteCharacterSegue", sender: self)
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}

extension FavoritesViewController: UICollectionViewDelegateFlowLayout {
    
    // MARK: - Collection View Delegate Flow Layout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = (collectionView.bounds.width/3) - minimumSpacing
        return CGSize(width: size, height: size)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return minimumSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return minimumSpacing
    }
    
}
