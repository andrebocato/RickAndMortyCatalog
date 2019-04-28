//
//  DetailLogicController.swift
//  RickAndMortyCatalog
//
//  Created by Andre Sanches Bocato on 26/04/19.
//  Copyright © 2019 Andre Sanches Bocato. All rights reserved.
//

import Foundation

class DetailLogicController {
    
    // MARK: - Dependencies
    
    private var modelController: RMCharacterModelController
    
    // MARK: - Public Properties
    
    /// Delegate to make the view react to its events
    weak var delegate: DetailLogicControllerDelegate?
    
    /// Exposes the character from
    var character: RMCharacter {
        return modelController.character
    }
    
    // Exposes the isFavorite computed property from the modelController
    var isFavoriteCharacter: Bool {
        return modelController.isFavorite
    }
    
    // MARK: - Initialization
    
    init(modelController: RMCharacterModelController) {
        self.modelController = modelController
        self.modelController.delegate = self
    }
    
    // MARK: - Functions
    
    /// Toggle the character as favorite
    func toggleFavorite() {
        if modelController.isFavorite {
            modelController.removeFromFavorites()
        } else {
            modelController.addToFavorites()
        }
    }
    
    /// Fetches the image data from persistence or downloads it.
    ///
    /// - Parameter completion: Returns the image data asynchronously.
    func fetchImageData(completion: @escaping (Data) -> Void) {
        modelController.fetchImageData(completion: completion)
    }
    
}

extension DetailLogicController: RMCharacterModelControllerDelegate {
    
    func stateDidChange(_ newState: RMCharacterModelControllerState) {
        switch newState {
        case .businessError(let be):
            delegate?.stateDidChange(.error(be))
        case .loadingImage(let isLoading):
            delegate?.stateDidChange(.loadingImage(isLoading))
        case .favoritePropertyChanged(let isFavorite):
            delegate?.favoriteStateChanged(isFavorite)
        }
    }
    
}
