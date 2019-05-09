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
    
    // MARK: - Dependencies

    private let logicController: SettingsLogicController
    
    // MARK: - Initialization
    init(nibName nibNameOrNil: String?,
         bundle nibBundleOrNil: Bundle?,
         logicController: SettingsLogicController) {
        self.logicController = logicController
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.toolbar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.toolbar.isHidden = false
    }
    
    // MARK: - IBActions
    
    @IBAction private func deleteAllFavoritesButtonDidReceiveTouchUpInside(_ sender: Any) {
        AlertHelper.presentAlert(inController: self, title: "Deleting favorites", message: "Are you sure you want to delete all your favorited characters? This action can't be undone.", rightAction: UIAlertAction(title: "Delete", style: .destructive, handler: nil)) { [weak self] in
            self?.logicController.deleteAllFavorites { [weak self] (result) in
                switch result {
                case .failure(let error):
                    AlertHelper.presentAlert(inController: self, title: "Error!", message: error.localizedDescription)
                default: return
                }
            }
        }
    }

}
