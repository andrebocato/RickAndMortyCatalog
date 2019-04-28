//
//  DetailLogicControllerDelegate.swift
//  RickAndMortyCatalog
//
//  Created by Eduardo Sanches Bocato on 27/04/19.
//  Copyright © 2019 Andre Sanches Bocato. All rights reserved.
//

import Foundation

/// Defines a communication strategy between the ligic controller holder and its events.
protocol DetailLogicControllerDelegate: AnyObject {
    
    /// Tells us that the characters logic had a state change.
    ///
    /// - Parameter newState: A new state to be rendered.
    func stateDidChange(_ newState: DetailLogicControllerState)
    
    /// Notifies that the favorite state has changed
    ///
    /// - Parameter isFavorite: Defines the favorite state.
    func favoriteStateChanged(_ isFavorite: Bool)
}
