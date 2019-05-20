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
    private static let urlSessionDispatcher = URLSessionDispatcher()
    private static let cacheService = CacheService(cacheDirectoryName: "RickAndMortyCatalogCache")
    
    // MARK: - Public
    
    static let charactersService = RMCharactersService(dispatcher: urlSessionDispatcher)
    static let imageService = ImageService(networkDispatcher: urlSessionDispatcher, cacheService: cacheService)
    static let favoritesDatabase = FavoritesDatabase()
    static let userDefaults = UserDefaultsImplementation()
    static let themeUpdater = ThemeUpdater()
    static let urlOpener: URLOpenerProtocol = UIApplication.shared
    
}
