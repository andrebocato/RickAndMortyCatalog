//
//  DetailLogicControllerState.swift
//  RickAndMortyCatalog
//
//  Created by Eduardo Sanches Bocato on 27/04/19.
//  Copyright © 2019 Andre Sanches Bocato. All rights reserved.
//

import Foundation

/// Defines the model controller states to be reflected on the logic controller holder.
///
/// - loadingImage: Defines a loading state to be applied to the view refering a character image.
/// - businessError: A business logic error has happened.
enum DetailLogicControllerState {
    case loadingImage(Bool)
    case error(Error)
}
