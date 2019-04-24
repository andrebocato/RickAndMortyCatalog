//
//  DependencyInjection.swift
//  RickAndMortyCatalog
//
//  Created by Eduardo Sanches Bocato on 23/04/19.
//  Copyright © 2019 Andre Sanches Bocato. All rights reserved.
//

import Foundation

struct DependencyInjection {
    
    private init() {}
    
    private static let urlSessionDispatcher = URLSessionDispatcher()
    private static let cacheService = CacheService(documentDirectoryPath: "RickAndMortyCatalogCache")
    static let charactersService = RMCharactersService(dispatcher: urlSessionDispatcher)
    static let imageService = ImageService(networkDispatcher: urlSessionDispatcher, cacheService: cacheService)
    
}
