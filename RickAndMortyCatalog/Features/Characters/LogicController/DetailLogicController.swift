//
//  DetailLogicController.swift
//  RickAndMortyCatalog
//
//  Created by Andre Sanches Bocato on 26/04/19.
//  Copyright © 2019 Andre Sanches Bocato. All rights reserved.
//

import Foundation

class DetailLogicController {
    
    // MARK: - Dependencies
    
    private let modelControllerFactory: ModelControllersFactoryProtocol
    
    // MARK: - Initialization
    
    init(modelControllerFactory: ModelControllersFactoryProtocol) {
        self.modelControllerFactory = modelControllerFactory
    }
    
    /// Defines a modelController for a RMCharacter.
    ///
    /// - Parameter character: The model used to define the model controller.
    /// - Returns: The modelController for the specified character.
    func modelController(for character: RMCharacter) -> RMCharacterModelController {
        return modelControllerFactory.createRMCharacterModelController(character: character)
    }
    
}
