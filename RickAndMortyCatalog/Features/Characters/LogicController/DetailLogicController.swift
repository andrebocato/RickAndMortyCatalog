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
    
    private let modelController: RMCharacterModelController
    
    // MARK: - Public Properties
    
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
    }
    
    // MARK: - Functions
    
    /// Toggle the character as favorite
    ///
    /// - Parameter handler: a callback to call the next action
    func toggleFavorite(then handler: (() -> ())? = nil) {
        if modelController.isFavorite {
            modelController.removeFromFavorites {
                handler?()
            }
        } else {
            modelController.addToFavorites {
                handler?()
            }
        }
    }
    
    /// Fetches the image data from persistence or downloads it.
    ///
    /// - Parameter completion: Returns the image data asynchronously.
    func fetchImageData(completion: @escaping (Data) -> Void) {
        modelController.fetchImageData(completion: completion)
    }
    
}
