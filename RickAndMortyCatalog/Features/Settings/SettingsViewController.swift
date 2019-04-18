//
//  SettingsViewController.swift
//  RickAndMortyCatalog
//
//  Created by Andre Sanches Bocato on 09/04/19.
//  Copyright © 2019 Andre Sanches Bocato. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    // MARK: - IBOutlets
    
    @IBOutlet private weak var clearFavoritesButton: UIButton!
    
    // MARK: - IBActions
    
    @IBAction private func clearFavoritesButtonDidReceiveTouchUpInside(_ sender: Any) {
        clearFavorites()
    }
    
    // MARK: - Properties
    
    // MARK: - Lifecycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.toolbar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.toolbar.isHidden = false
        
        // @TODO: if view has changes, show alert asking if user wants to discard changes and put line below in completion
        persistChanges()
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Functions
    
    private func persistChanges() {
        // @TODO: implement
    }
    
    private func clearFavorites() {
        // @TODO: implement
    }
    
    // MARK: - Configuration Functions
    
    // MARK: - Helper Functions

}
