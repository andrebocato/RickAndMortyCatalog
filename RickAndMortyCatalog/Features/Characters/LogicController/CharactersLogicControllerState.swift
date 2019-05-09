//
//  CharactersLogicControllerState.swift
//  RickAndMortyCatalog
//
//  Created by Andre Sanches Bocato on 25/04/19.
//  Copyright © 2019 Andre Sanches Bocato. All rights reserved.
//

import Foundation

/// Defines the logic controller states to be reflected on the View.
///
/// - loadingCharacters: Defines a loading state to be applied to the view refering to a character loading.
/// - loadingNextPage: Defines a loading state to be applied to the view refering to a page loading.
/// - serviceError: Defines a service error event to be handled.
enum CharactersLogicControllerState {
    case loadingCharacters(Bool)
    case loadingNextPage(Bool)
    case serviceError(ServiceError)
}
