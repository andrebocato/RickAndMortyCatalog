//
//  RMCharacterModelControllerState.swift
//  RickAndMortyCatalog
//
//  Created by Andre Sanches Bocato on 25/04/19.
//  Copyright © 2019 Andre Sanches Bocato. All rights reserved.
//

import Foundation

/// Defines the model controller states to be reflected on the model holder.
///
/// - loadingImage: Defines a loading state to be applied to the view refering a character image.
/// - businessError: A business logic error has happened.
enum RMCharacterModelControllerState {
    case loadingImage(Bool)
    case businessError(RMCharacterModelControllerBusinessError)
    case favoritePropertyChanged(Bool)
}
