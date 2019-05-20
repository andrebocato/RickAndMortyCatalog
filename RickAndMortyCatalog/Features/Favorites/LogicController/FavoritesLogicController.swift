//
//  FavoritesLogicController.swift
//  RickAndMortyCatalog
//
//  Created by Andre Sanches Bocato on 27/04/19.
//  Copyright © 2019 Andre Sanches Bocato. All rights reserved.
//

import Foundation

class FavoritesLogicController {
    
    // MARK: - Public Properties
    
    /// Delegate to make the view react to its events
    weak var delegate: FavoritesLogicControllerDelegate?

    /// Returns the number of fetched characters.
    var numberOfFavorites: Int {
        return favorites.count
    }
    
    // MARK: - Dependencies
    
    private let database: FavoritesDatabaseProtocol
    private let modelControllerFactory: ModelControllersFactoryProtocol
    
    // MARK: - Private Properties
    private var favorites: [FavoriteCharacter] = [] {
        didSet {
            delegate?.favoritesListDidUpdate()
        }
    }
    
    // MARK: - Initialization
    
    init(database: FavoritesDatabase,
         modelControllerFactory: ModelControllersFactoryProtocol) {
        self.database = database
        self.modelControllerFactory = modelControllerFactory
    }
    
    // MARK: - Public Functions
    
    /// Defines the modelController for a row.
    ///
    /// - Parameter index: The index to be worked on.
    /// - Returns: The modelController to the model on the specified row.
    func modelController(for index: Int) -> RMCharacterModelController {
        let rmCharacter = favorites[index].rmCharacter
        let modelController = modelControllerFactory.createRMCharacterModelController(character: rmCharacter)
        return modelController
    }
    
    /// Gets all favorites from the database
    func loadFavorites() {
        do {
            let fetchedFavorites = try database.fetchAllFavorites()
            favorites = fetchedFavorites
        } catch {
            delegate?.databaseFetchDidFailWithError(error)
        }
    }
    
}
