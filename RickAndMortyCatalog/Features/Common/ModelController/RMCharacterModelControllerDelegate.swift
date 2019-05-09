//
//  RMCharacterModelControllerDelegate.swift
//  RickAndMortyCatalog
//
//  Created by Andre Sanches Bocato on 25/04/19.
//  Copyright © 2019 Andre Sanches Bocato. All rights reserved.
//

import Foundation

/// Defines a communication strategy between the model holder and it's logic.
protocol RMCharacterModelControllerDelegate: AnyObject {
    
    /// Tells us that the characters logic had a state change.
    ///
    /// - Parameter newState: A new state to be rendered.
    func stateDidChange(_ newState: RMCharacterModelControllerState)
}
