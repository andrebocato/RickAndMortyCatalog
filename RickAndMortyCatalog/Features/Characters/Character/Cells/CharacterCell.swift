//
//  CharacterCell.swift
//  RickAndMortyCatalog
//
//  Created by Andre Sanches Bocato on 23/04/19.
//  Copyright © 2019 Andre Sanches Bocato. All rights reserved.
//

import UIKit

class CharacterCell: UITableViewCell {

    // MARK: - IBOutlets

    @IBOutlet private weak var cellImageView: UIImageView! {
        didSet {
            cellImageView.layer.cornerRadius = 10
        }
    }
    
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var idLabel: UILabel!
    @IBOutlet private weak var favoriteButton: UIButton!
    
    // MARK: - Private Properties
    
    private var modelController: RMCharacterModelController!
    private var onFavoriteErrorCallBack: ((_ error: Error) -> Void)?
    
    // MARK: - Lifecycle
    
    override func prepareForReuse() {
        super.prepareForReuse()
        modelController.cancelImageRequest()
    }
    
    // MARK: - Configuration Functions
    
    /// <#Description#>
    ///
    /// - Parameter modelController: <#modelController description#>
    func configure(with modelController: RMCharacterModelController, onFavoriteErrorCallBack: ((_ error: Error) -> Void)? = nil) {
        self.modelController = modelController
        self.modelController.delegate = self
        self.onFavoriteErrorCallBack = onFavoriteErrorCallBack
        setupUI()
    }
    
    // MARK: - IBActions
    
    @IBAction func favoriteButtonDidReceiveTouchUpInside(_ sender: Any) {
        let isFavorite = modelController.isFavorite
        if !isFavorite {
            modelController.addToFavorites(onSuccess: setupFavoriteButton)
        } else {
            modelController.removeFromFavorites(onSuccess: setupFavoriteButton)
        }
    }
    
    // MARK: - Private Functions
    
    private func setupUI() {
        setupImage()
        setupLabels()
        setupFavoriteButton()
    }
    
    private func setupImage() {
        modelController.fetchImageData { [weak self] (data) in
            DispatchQueue.main.async {
                self?.cellImageView.image = UIImage(data: data)
            }
        }
    }
    
    private func setupLabels() {
        idLabel.text = " #\(modelController.character.id)"
        nameLabel.text = modelController.character.name
    }
    
    private func setupFavoriteButton() {
//        DispatchQueue.main.async {
            let buttonImageName = self.modelController.isFavorite ? "favorited" : "unfavorited"
            let favoriteButtonImage = UIImage(named: buttonImageName)
            self.favoriteButton.setImage(favoriteButtonImage, for: .normal)
//        }
    }
    
}

extension CharacterCell: RMCharacterModelControllerDelegate {
    
    func stateDidChange(_ newState: RMCharacterModelControllerState) {
        switch newState {
        case .loadingImage(let value): handleLoadingImageState(value)
        case .businessError(let error): handleBusinessError(error)
        }
    }
    
    private func handleLoadingImageState(_ loading: Bool) {
        DispatchQueue.main.async {
//            loading ? self.cellImageView.startLoading() : self.cellImageView.startLoading()
        }
    }
    
    private func handleBusinessError(_ error: Error) {
        onFavoriteErrorCallBack?(error)
    }
    
}
