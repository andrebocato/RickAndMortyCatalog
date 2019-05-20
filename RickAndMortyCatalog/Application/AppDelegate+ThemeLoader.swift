//
//  AppDelegate+ThemeLoader.swift
//  RickAndMortyCatalog
//
//  Created by Eduardo Sanches Bocato on 20/05/19.
//  Copyright © 2019 Andre Sanches Bocato. All rights reserved.
//

import Foundation

extension AppDelegate: ThemeLoader {
    
    func loadApplicationTheme() { // TODO: Refactor this
        let isDarkThemeOn = DependencyInjection.themeManager.isDarkThemeOn()
        let currentTheme: Theme = isDarkThemeOn ? .dark : .default
        DependencyInjection.themeUpdater.updateApplicationWithTheme(newTheme: currentTheme)
    }
    
}
