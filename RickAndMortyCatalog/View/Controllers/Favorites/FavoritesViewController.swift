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
    
    // MARK: - Properties
    
    // MARK: - Lifecycle
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destination = segue.destination as? LocationDetailViewController, segue.destination is LocationDetailViewController else { return }
        
        if segue.identifier == "LocationDetailSegue" {
            // @TODO: pass data to next view controller
        }
    }
    
    // MARK: - Functions
    
    // MARK: - Configuration
    
    // MARK: - Helper Functions
    
}

// MARK: - Extensions

extension FavoritesViewController: UICollectionViewDataSource {
    
    // MARK: - Collection View Data Source
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // @TODO: retun number of favorites
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // @TODO: implement method properly
        return UICollectionViewCell()
    }
    
}

extension FavoritesViewController: UICollectionViewDelegate {
    
    // MARK: - Collection View Delegate
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "LocationDetailSegue", sender: self)
    }
}
