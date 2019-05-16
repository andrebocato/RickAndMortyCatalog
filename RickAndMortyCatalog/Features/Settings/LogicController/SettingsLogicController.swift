//
//  SettingsLogicController.swift
//  RickAndMortyCatalog
//
//  Created by Andre Sanches Bocato on 27/04/19.
//  Copyright © 2019 Andre Sanches Bocato. All rights reserved.
//

import Foundation

class SettingsLogicController {

    // MARK: - Dependencies
    
    private let favoritesDatabase: FavoritesDatabaseProtocol
    private let themeUpdater: ThemeUpdaterProtocol
    
    // MARK: - Initialization
    
    init(favoritesDatabase: FavoritesDatabaseProtocol,
         themeUpdater: ThemeUpdaterProtocol) {
        self.favoritesDatabase = favoritesDatabase
        self.themeUpdater = themeUpdater
    }
    
    // MARK: - Functions
    
    /// Deletes all the favorites.
    ///
    /// - Parameter completion: Returns a result with success and error.
    func deleteAllFavorites(completion: ((_ result: Result<Void, Error>) -> Void)? = nil) {
        do {
            try favoritesDatabase.deleteAll()
            completion?(.success(()))
        } catch {
            completion?(.failure(error))
        }
    }
    
    /// Toggles the dark theme on or off.
    ///
    /// - Parameter enabled: Send true to enable the theme, false to disable it.
    func toggleDarkTheme(_ enabled: Bool) {
        let newTheme: Theme = enabled ? .dark : .default
        themeUpdater.updateApplicationWithTheme(newTheme: newTheme)
    }
    
}
