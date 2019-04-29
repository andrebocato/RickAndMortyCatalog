//
//  FavoriteDatabaseObjectChange.swift
//  RickAndMortyCatalog
//
//  Created by Andre Sanches Bocato on 28/04/19.
//  Copyright © 2019 Andre Sanches Bocato. All rights reserved.
//

import Foundation

/// Define an object change
///
/// - updated: The object was updated.
/// - deleted: The object was deleted.
enum FavoriteDatabaseObjectChange {
    case updated
    case deleted
}
