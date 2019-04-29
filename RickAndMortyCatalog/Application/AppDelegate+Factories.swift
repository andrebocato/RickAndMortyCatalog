//
//  AppDelegate+Factories.swift
//  RickAndMortyCatalog
//
//  Created by Andre Sanches Bocato on 28/04/19.
//  Copyright © 2019 Andre Sanches Bocato. All rights reserved.
//

import Foundation
import UIKit

extension AppDelegate: ModelControllersFactoryProtocol {
    
    func createRMCharacterModelController(character: RMCharacter) -> RMCharacterModelController {
        return RMCharacterModelController(character: character,
                                          service: DependencyInjection.imageService,
                                          favoritesDatabase: DependencyInjection.favoritesDatabase)
    }
    
}

extension AppDelegate: ViewControllersFactoryProtocol {
    
    func createDetailsViewController(characterModelController: RMCharacterModelController) -> DetailViewController {
        let logicController = DetailLogicController(modelController: characterModelController)
        return DetailViewController(nibName: DetailViewController.className,
                                    bundle: Bundle(for: DetailViewController.self),
                                    logicController: logicController)
    }
    
    func createCharactersViewController() -> CharactersViewController {
        let charactersLogicController = CharactersLogicController(service: DependencyInjection.charactersService,
                                                                  modelControllerFactory: self)
        let charactersViewController = CharactersViewController(nibName: CharactersViewController.className,
                                                                bundle: Bundle(for: CharactersViewController.self),
                                                                logicController: charactersLogicController,
                                                                viewControllersFactory: self)
        charactersLogicController.delegate = charactersViewController
        return charactersViewController
    }
    
    func createFavoritesViewController() -> FavoritesViewController {
        let favoritesLogicController = FavoritesLogicController(database: DependencyInjection.favoritesDatabase,
                                                                modelControllerFactory: self)
        let favoritesViewController = FavoritesViewController(nibName: FavoritesViewController.className,
                                                              bundle: Bundle(for: FavoritesViewController.self),
                                                              logicController: favoritesLogicController,
                                                              viewControllersFactory: self)
        favoritesLogicController.delegate = favoritesViewController
        return favoritesViewController
    }
    
    func createSettingsViewController() ->  SettingsViewController {
        let settingsLogicController = SettingsLogicController(favoritesDatabase: DependencyInjection.favoritesDatabase)
        return SettingsViewController(nibName: SettingsViewController.className,
                                      bundle: Bundle(for: SettingsViewController.self),
                                      logicController: settingsLogicController)
    }
    
    func createTabBarController() ->  UITabBarController {
        
        // CharactersViewController
        let charactersViewController = createCharactersViewController()
        charactersViewController.title = "Characters"
        charactersViewController.tabBarItem = UITabBarItem(title: "Characters", image: UIImage(named: "characters"), tag: 0)
        let charactersNavigationController = UINavigationController(rootViewController: charactersViewController)
        
        // FavoritesViewController
        let favoritesViewController = createFavoritesViewController()
        favoritesViewController.title = "Favorites"
        favoritesViewController.tabBarItem = UITabBarItem(title: "Favorites", image: UIImage(named: "favorited"), tag: 1)
        let favoritesNavigationController = UINavigationController(rootViewController: favoritesViewController)
        
        // CharactersViewController
        let settingsViewController = createSettingsViewController()
        settingsViewController.title = "Settings"
        settingsViewController.tabBarItem = UITabBarItem(title: "Settings", image: UIImage(named: "settings"), tag: 2)
        let settingsNavigationController = UINavigationController(rootViewController: settingsViewController)
        
        // UITabBarController
        let tabBarController = UITabBarController()
        tabBarController.setViewControllers([charactersNavigationController,
                                             favoritesNavigationController,
                                             settingsNavigationController],
                                            animated: false)
        
        return tabBarController
    }
    
}
