//
//  ViewControllersFactory.swift
//  RickAndMortyCatalog
//
//  Created by Andre Sanches Bocato on 26/04/19.
//  Copyright © 2019 Andre Sanches Bocato. All rights reserved.
//

import UIKit

/// This is an abstract factory for view controllers.
protocol ViewControllersFactoryProtocol {
    
    /// Creates a model controller from a character.
    ///
    /// - Parameter character: A RMCharacter.
    /// - Returns: A configured model controller.
    func createDetailsViewController(characterModelController: RMCharacterModelController) -> DetailViewController
    
}
