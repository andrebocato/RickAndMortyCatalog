//
//  RMCharacterModelControllerBusinessError.swift
//  RickAndMortyCatalog
//
//  Created by Eduardo Sanches Bocato on 25/04/19.
//  Copyright © 2019 Andre Sanches Bocato. All rights reserved.
//

import Foundation

/// Defines business errors for the model controller
enum RMCharacterModelControllerBusinessError: Error {
    
    case couldNotAddToFavorites
    case couldNotRemoteFromFavorites
    
    var localizedDescription: String {
        switch self {
        case .couldNotAddToFavorites: return "Could not add to Favorites."
        case .couldNotRemoteFromFavorites: return "Could not remove from Favorites."
        }
    }
    
}
