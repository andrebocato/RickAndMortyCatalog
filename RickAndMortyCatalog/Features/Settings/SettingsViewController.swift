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
    
    // MARK: - IBActions
    
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
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Functions
    
    // MARK: - Configuration
    
    // MARK: - Helper Functions

}
