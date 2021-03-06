//
//  SettingsLogicController.swift
//  RickAndMortyCatalog
//
//  Created by Andre Sanches Bocato on 27/04/19.
//  Copyright © 2019 Andre Sanches Bocato. All rights reserved.
//

import Foundation

class SettingsLogicController {
    
    // MARK: - URL Strings
    
    private let githubRepoURL = "https://github.com/andrebocato/RickAndMortyCatalog"
    private let apiDocumentationURL = "https://rickandmortyapi.com/documentation/"
    
    // MARK: - Dependencies
    
    private let favoritesDatabase: FavoritesDatabaseProtocol
    private let themeUpdater: ThemeUpdaterProtocol
    private let urlOpener: URLOpenerProtocol
    private let themeManager: ThemeManagerProtocol
    
    // MARK: - Public Properties
    
    var isDarkThemeOn: Bool {
        return themeManager.isDarkThemeOn()
    }
    
    // @TODO: change this
    let settings = [
        ["Delete all favorites"],
        ["Switch to dark mode"],
        ["Source code (GitHub)", "API Documentation"]
    ]
    
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
    
    // MARK: - Public Functions
    
    /// Deletes all the favorites.
    ///
    /// - Parameter completion: Returns a result with success and error.
    public func deleteAllFavorites(completion: ((_ result: Result<Void, Error>) -> Void)? = nil) {
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
    public func toggleDarkTheme(_ enabled: Bool) {
        let newTheme: Theme = enabled ? .dark : .light
        themeManager.setDarkThemeOn(enabled)
        themeUpdater.updateApplicationWithTheme(newTheme: newTheme)
    }
    
    /// Opens the GitHub repository URL.
    ///
    /// - Parameter onError: Closure called in case an error occurs.
    public func openGithubRepo(onError: ((_ error: Error) -> Void)? = nil) {
        open(urlString: githubRepoURL, onError: { originalError in
            debugPrint(originalError)
            let error = NSError(domain: "SettingsLogicController", code: -1, description: "Could not open Github Repo.")
            onError?(error)
        })
    }
    
    /// Opens the API documentation URL.
    ///
    /// - Parameter onError: Closure called in case an error occurs.
    public func openAPIDocumentation(onError: ((_ error: Error) -> Void)? = nil) {
        open(urlString: apiDocumentationURL, onError: { originalError in
            debugPrint(originalError)
            let error = NSError(domain: "SettingsLogicController", code: -1, description: "Could not open API Documentation.")
            onError?(error)
        })
    }
    
    // MARK: - Private Functions
    
    /// Opens a URL using a string.
    ///
    /// - Parameter url: A string URL to be opened.
    private func open(urlString: String, onError: (_ error: Error) -> Void) {
        if let url = URL(string: urlString), urlOpener.canOpenURL(url) {
            urlOpener.open(url, options: [:], completionHandler: nil)
        } else {
            let error = NSError(domain: "SettingsLogicController", code: -1, description: "Could not open URL: \(urlString)")
            onError(error)
        }
    }
    
}
