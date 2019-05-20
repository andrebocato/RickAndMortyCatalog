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
    private let urlOpener: URLOpenerProtocol
    private let themeManager: ThemeManagerProtocol
    
    // MARK: - Public Properties
    var isDarkThemeOn: Bool {
        return themeManager.isDarkThemeOn()
    }
    
    // MARK: - Initialization
    
    init(favoritesDatabase: FavoritesDatabaseProtocol,
         themeUpdater: ThemeUpdaterProtocol,
         urlOpener: URLOpenerProtocol,
         themeManager: ThemeManagerProtocol) {
        self.favoritesDatabase = favoritesDatabase
        self.themeUpdater = themeUpdater
        self.urlOpener = urlOpener
        self.themeManager = themeManager
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
        themeManager.setDarkThemeOn(enabled)
        themeUpdater.updateApplicationWithTheme(newTheme: newTheme)
    }
    
    
    /// Opens a URL using a string.
    ///
    /// - Parameter url: A string URL to be opened.
    func open(urlString: String) {
        if let url = URL(string: urlString), urlOpener.canOpenURL(url) {
            urlOpener.open(url, options: [:], completionHandler: nil)
        } else {
            // @TODO: handle error
        }
    }
    
}
