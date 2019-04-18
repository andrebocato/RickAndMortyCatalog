//
//  SearchViewController.swift
//  RickAndMortyCatalog
//
//  Created by André Sanches Bocato on 17/04/19.
//  Copyright © 2019 Andre Sanches Bocato. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    // MARK: - IBActions
    
    // MARK: - Properties
    
    // MARK: - Lifecycle
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destination = segue.destination as? CharacterDetailViewController, segue.destination is CharacterDetailViewController else { return }
        
        if segue.identifier == "SearchCharacterSegue" {
            // @TODO: pass character
        }
    }
    
    // MARK: - Functions
    
    // MARK: - Configuration Functions
    
    // MARK: - Helper Functions
    
}
