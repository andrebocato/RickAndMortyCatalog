//
//  SettingsLogicController.swift
//  RickAndMortyCatalog
//
//  Created by Eduardo Sanches Bocato on 27/04/19.
//  Copyright © 2019 Andre Sanches Bocato. All rights reserved.
//

import Foundation

class SettingsLogicController {

    // MARK: - Dependencies
    
    private let favoritesDatabase: FavoritesDatabaseProtocol
    
    // MARK: - Initialization
    
    /// Initializes the logic controller with its dependencies
    ///
    /// - Parameter favoritesDatabase: a favorites database instance
    init(favoritesDatabase: FavoritesDatabaseProtocol) {
        self.favoritesDatabase = favoritesDatabase
    }
    
    // MARK: - Functions
    
    /// Deletes all the favorites
    ///
    /// - Parameter completion: returns a result, for success or error
    func deleteAllFavorites(completion: ((_ result: Result<Void, Error>) -> Void)? = nil) {
        do {
            try favoritesDatabase.deleteAll()
            completion?(.success(()))
        } catch {
            completion?(.failure(error))
        }
    }
    
}
