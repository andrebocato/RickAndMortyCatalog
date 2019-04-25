//
//  ModelControllersFactory.swift
//  RickAndMortyCatalog
//
//  Created by AndreAndreAndre Sanches Bocato on 25/04/19.
//  Copyright © 2019 Andre Sanches Bocato. All rights reserved.
//

import Foundation

/// This is an abstract factory for model controllers.
protocol ModelControllersFactoryProtocol {
    
    /// Creates a model controller from a character.
    ///
    /// - Parameter character: A RMCharacter.
    /// - Returns: A configured model controller.
    func createRMCharacterModelController(character: RMCharacter) -> RMCharacterModelController
    
}
