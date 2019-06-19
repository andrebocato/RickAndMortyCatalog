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
    /// Creates a configured instance of a DetailViewController.
    ///
    /// - Parameter characterModelController: A model controller for the character.
    /// - Returns: A configured DetailViewController.
    func createDetailsViewController(characterModelController: RMCharacterModelController) -> DetailViewController
    /// Creates a configured instance of a CharactersViewController.
    ///
    /// - Returns: A configured CharactersViewController.
    func createCharactersViewController() -> CharactersViewController
    /// Creates a configured instance of a FavoritesViewController.
    ///
    /// - Returns: A configured FavoritesViewController.
    func createFavoritesViewController() -> FavoritesViewController
    /// Creates a configured instance of a SettingsViewController.
    ///
    /// - Returns: A configured SettingsViewController.
    func createSettingsViewController() -> SettingsViewController
    /// Creates a TabBarController (applications root controller).
    ///
    /// - Returns: A configured instance of a TabBarController.
    func createTabBarController() -> UITabBarController
}
