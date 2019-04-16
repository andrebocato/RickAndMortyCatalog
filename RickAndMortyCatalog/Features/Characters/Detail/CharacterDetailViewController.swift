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
    @IBOutlet private weak var idLabel: UILabel!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var statusLabel: UILabel!
    @IBOutlet private weak var speciesLabel: UILabel!
    @IBOutlet private weak var typeLabel: UILabel!
    @IBOutlet private weak var genderLabel: UILabel!
    @IBOutlet private weak var originNameLabel: UILabel!
    @IBOutlet private weak var locationNameLabel: UILabel!
    @IBOutlet private weak var episodesLabel: UILabel!
  
    @IBOutlet private weak var id: UILabel!
    @IBOutlet private weak var name: UILabel!
    @IBOutlet private weak var status: UILabel!
    @IBOutlet private weak var species: UILabel!
    @IBOutlet private weak var type: UILabel!
    @IBOutlet private weak var gender: UILabel!
    @IBOutlet private weak var origin: UILabel!
    @IBOutlet private weak var location: UILabel!
    @IBOutlet private weak var episodes: UILabel!
    
    
    // MARK: - IBActions
    
    @IBAction private func toggleFavoriteBarButtonItemDidReceiveTouchUpInside(_ sender: Any) {
        // @TODO: change image for favorited
    }
    
    // MARK: - Properties
    
    var character: RMCharacter!
    
    // MARK: - Lifecycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.toolbar.isHidden = true
        
        id.text = String(describing: character.id)
        name.text = character.name
        status.text = character.status
        status.text = character.status
        species.text = character.species
        type.text = character.type
        gender.text = character.gender
        origin.text = character.origin?.name
        location.text = character.location?.name
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.toolbar.isHidden = false
    }
    
    // MARK: - Functions
    
    // MARK: - Configuration Functions
    
    // MARK: - Helper Functions
    
}
