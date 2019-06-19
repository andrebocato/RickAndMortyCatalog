//
//  DependencyInjection.swift
//  RickAndMortyCatalog
//
//  Created by Andre Sanches Bocato on 23/04/19.
//  Copyright © 2019 Andre Sanches Bocato. All rights reserved.
//

import Foundation
import RealmSwift

struct DependencyInjection {
    
    // MARK: - Private
    
    private init() {}
    private static let urlSessionDispatcher: URLRequestDispatcherProtocol = URLSessionDispatcher()
    private static let cacheService: CacheServiceProtocol = CacheService(cacheDirectoryName: "RickAndMortyCatalogCache")
    
    // MARK: - Public
    
    static let charactersService: RMCharactersServiceProtocol = RMCharactersService(dispatcher: urlSessionDispatcher)
    static let imageService: ImageServiceProtocol = ImageService(networkDispatcher: urlSessionDispatcher, cacheService: cacheService)
    static let favoritesDatabase = FavoritesDatabase()
    static let themeManager: ThemeManagerProtocol = UserDefaultsThemeManager()
    static let themeUpdater: ThemeUpdaterProtocol = ThemeUpdater()
    static let urlOpener: URLOpenerProtocol = UIApplication.shared
    
}
