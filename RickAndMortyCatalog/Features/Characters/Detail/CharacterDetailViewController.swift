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
    
    // MARK: - Dependencies
    
    private let service: RMCharactersServiceProtocol
    private let character: RMCharacter
    
    // MARK: - Initialization
    
    init(nibName nibNameOrNil: String?,
         bundle nibBundleOrNil: Bundle?,
         service: RMCharactersServiceProtocol,
         character: RMCharacter) {
        self.service = service
        self.character = character
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBarButtonItem()
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
    
    // MARK: - UI
    
    private func setupBarButtonItem() {
        let barButtonItem = UIBarButtonItem(image:  UIImage(named: "unfavorited"), style: .done, target: self, action: #selector(toggleFavoriteBarButtonItemDidReceiveTouchUpInside(_:)))
        navigationItem.rightBarButtonItem = barButtonItem
    }
    
    // MARK: - Actions
    
    @objc private func toggleFavoriteBarButtonItemDidReceiveTouchUpInside(_ sender: UIBarButtonItem) {
        if sender.image == UIImage(named: "unfavorited") {
            sender.image = UIImage(named: "favorited")
        } else {
            sender.image = UIImage(named: "unfavorited")
        }
        // @TODO: if character is favorite, switch image and delete persisted data. else, set isFavorite to true and persist data.
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
        loadImage(for: character)
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
    
    private func loadImage(for character: RMCharacter) {
        
        imageView.startLoading()
        
        let imageURL = character.image
        service.getImageDataFromURL(imageURL) { [weak self] (result) in
            
            self?.imageView.stopLoading()
            
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    self?.imageView.image = UIImage(data: data)
                }
            case .failure(let error):
                debugPrint(error)
            }
            
            
        }
    }
    
    // MARK: - Helper Functions
    
}
