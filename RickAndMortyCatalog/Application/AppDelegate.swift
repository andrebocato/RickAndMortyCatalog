//
//  AppDelegate.swift
//  RickAndMortyCatalog
//
//  Created by Andre Sanches Bocato on 09/04/19.
//  Copyright © 2019 Andre Sanches Bocato. All rights reserved.
//
// API DOCUMENTATION: https://rickandmortyapi.com/documentation

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let rootViewController = createTabBarController()
        
        window = UIWindow()
        window?.rootViewController = rootViewController
        window?.makeKeyAndVisible()
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

extension AppDelegate {
    
    private func createTabBarController() ->  UITabBarController {
     
        // CharactersViewController
        // @TODO: Use Factory pattern
        let charactersLogicController = CharactersLogicController(service: DependencyInjection.charactersService,
                                                                  modelControllerFactory: self)
        let charactersViewController = CharactersViewController(nibName: CharactersViewController.className,
                                                                bundle: Bundle(for: CharactersViewController.self),
                                                                logicController: charactersLogicController,
                                                                viewControllersFactory: self)
        charactersLogicController.delegate = charactersViewController
        charactersViewController.title = "Characters"
        charactersViewController.tabBarItem = UITabBarItem(title: "Characters", image: UIImage(named: "characters"), tag: 0)
        let charactersNavigationController = UINavigationController(rootViewController: charactersViewController)
        
        // FavoritesViewController
        // @TODO: Use Factory pattern
        let favoritesLogicController = FavoritesLogicController(database: DependencyInjection.favoritesDatabase,
                                                                modelControllerFactory: self)
        let favoritesViewController = FavoritesViewController(nibName: FavoritesViewController.className,
                                                              bundle: Bundle(for: FavoritesViewController.self),
                                                              logicController: favoritesLogicController,
                                                              viewControllersFactory: self)
        favoritesViewController.title = "Favorites"
        favoritesViewController.tabBarItem = UITabBarItem(title: "Favorites", image: UIImage(named: "favorited"), tag: 1)
        let favoritesNavigationController = UINavigationController(rootViewController: favoritesViewController)
        
        // SettingsViewController
        // @TODO: Use Factory pattern
        let settingsLogicController = SettingsLogicController(favoritesDatabase: DependencyInjection.favoritesDatabase)
        let settingsViewController = SettingsViewController(nibName: SettingsViewController.className,
                                                            bundle: Bundle(for: SettingsViewController.self),
                                                            logicController: settingsLogicController)
        settingsViewController.title = "Settings"
        settingsViewController.tabBarItem = UITabBarItem(title: "Settings", image: UIImage(named: "settings"), tag: 2)
        let settingsNavigationController = UINavigationController(rootViewController: settingsViewController)
        
        // UITabBarController
        // @TODO: Use Factory pattern
        let tabBarController = UITabBarController()
        tabBarController.setViewControllers([charactersNavigationController, favoritesNavigationController, settingsNavigationController], animated: false)
        
        return tabBarController
    }
    
}

extension AppDelegate: ModelControllersFactoryProtocol { // @TODO: MAYBE move this from here
    
    func createRMCharacterModelController(character: RMCharacter) -> RMCharacterModelController {
        return RMCharacterModelController(character: character,
                                          service: DependencyInjection.imageService,
                                          favoritesDatabase: DependencyInjection.favoritesDatabase)
    }
    
}

extension AppDelegate: ViewControllersFactoryProtocol { // @TODO: MAYBE move this from here
    
    func createDetailsViewController(characterModelController: RMCharacterModelController) -> DetailViewController {
        let logicController = DetailLogicController(modelController: characterModelController)
        return DetailViewController(nibName: DetailViewController.className,
                                    bundle: Bundle(for: DetailViewController.self),
                                    logicController: logicController)
    }
    
}
