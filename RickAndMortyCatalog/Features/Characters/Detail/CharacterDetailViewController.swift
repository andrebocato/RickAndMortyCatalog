//
//  EpisodeDetailViewController.swift
//  RickAndMortyCatalog
//
//  Created by Andre Sanches Bocato on 09/04/19.
//  Copyright © 2019 Andre Sanches Bocato. All rights reserved.
//

import Foundation
import UIKit

class CharacterDetailViewController: UIViewController {

    // MARK: - IBOutlets
    
    @IBOutlet private weak var toggleFavoriteBarButtonItem: UIBarButtonItem!
    // @TODO: set labels for each field
    
    
    // MARK: - IBActions
    
    @IBAction private func toggleFavoriteBarButtonItemDidReceiveTouchUpInside(_ sender: Any) {
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
    }
    
    // MARK: - Functions
    
    // MARK: - Configuration
    
    // MARK: - Helper Functions
    
}
