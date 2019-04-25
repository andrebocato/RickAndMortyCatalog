//
//  CharactersLogicControllerDelegate.swift
//  RickAndMortyCatalog
//
//  Created by Eduardo Sanches Bocato on 25/04/19.
//  Copyright © 2019 Andre Sanches Bocato. All rights reserved.
//

import Foundation

/// Defines a communication strategy between the ViewController and it's logic
protocol CharactersLogicControllerDelegate: AnyObject {
    
    /// Tells us that the characters logic had a state change
    ///
    /// - Parameter newState: a new state to be rendered
    func stateDidChange(_ newState: CharactersLogicControllerState)
    
    /// Informs us that the character list has updated
    func charactersListDidUpdate()
}
