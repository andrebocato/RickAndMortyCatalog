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
    @IBOutlet private weak var idFixedLabel: UILabel!
    @IBOutlet private weak var nameFixedLabel: UILabel!
    @IBOutlet private weak var statusFixedLabel: UILabel!
    @IBOutlet private weak var speciesFixedLabel: UILabel!
    @IBOutlet private weak var typeFixedLabel: UILabel!
    @IBOutlet private weak var genderFixedLabel: UILabel!
    @IBOutlet private weak var originNameFixedLabel: UILabel!
    @IBOutlet private weak var locationNameFixedLabel: UILabel!

    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var idLabel: UILabel!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var statusLabel: UILabel!
    @IBOutlet private weak var speciesLabel: UILabel!
    @IBOutlet private weak var typeLabel: UILabel!
    @IBOutlet private weak var genderLabel: UILabel!
    @IBOutlet private weak var originLabel: UILabel!
    @IBOutlet private weak var locationLabel: UILabel!
    
    
    // MARK: - IBActions
    
    @IBAction private func toggleFavoriteBarButtonItemDidReceiveTouchUpInside(_ sender: Any) {
        if toggleFavoriteBarButtonItem.image == UIImage(named: "unfavorited") {
            toggleFavoriteBarButtonItem.image = UIImage(named: "favorited")
        } else {
            toggleFavoriteBarButtonItem.image = UIImage(named: "unfavorited")
        }
        // @TODO: if character is favorite, switch image and delete persisted data. else, set isFavorite to true and persist data.
    }
    
    // MARK: - Properties
    
    var character: RMCharacter!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView(with: character)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.toolbar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.toolbar.isHidden = false
    }
    
    // MARK: - Functions
    
    private func persistFavorite() {
        // @TODO: implement
    }
    
    private func deletePersistedFavorite() {
        // @TODO: implement
    }
    
    // MARK: - Configuration Functions
    
    private func configureView(with character: RMCharacter) {
        imageView.image = UIImage() // @TODO: populate with image
        idLabel.text = "\(character.id)"
        nameLabel.text = character.name
        statusLabel.text = character.status
        statusLabel.text = character.status
        speciesLabel.text = character.species
        typeLabel.text = character.type
        genderLabel.text = character.gender
        originLabel.text = character.origin.name
        locationLabel.text = character.location.name
    }
    
    // MARK: - Helper Functions
    
}
