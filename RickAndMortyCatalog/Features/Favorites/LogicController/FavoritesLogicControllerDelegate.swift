//
//  FavoritesLogicControllerDelegate.swift
//  RickAndMortyCatalog
//
//  Created by Andre Sanches Bocato on 27/04/19.
//  Copyright © 2019 Andre Sanches Bocato. All rights reserved.
//

import Foundation

/// Defines a communication strategy between the ViewController and its logic.
protocol FavoritesLogicControllerDelegate: AnyObject {
    
    /// Informs us that the favorites list has updated.
    func favoritesListDidUpdate()
    
    /// Notifies that there was an error with the database.
    ///
    /// - Parameter error: An error.
    func databaseFetchDidFailWithError(_ error: Error)
}
