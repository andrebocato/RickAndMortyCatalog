//
//  AppDelegate+ThemeLoader.swift
//  RickAndMortyCatalog
//
//  Created by Eduardo Sanches Bocato on 20/05/19.
//  Copyright © 2019 Andre Sanches Bocato. All rights reserved.
//

import Foundation

// MARK: - Theme Loader

extension AppDelegate: ThemeLoader {
    
    func loadApplicationTheme() {
        let isDarkThemeOn = DependencyInjection.themeManager.isDarkThemeOn()
        let currentTheme: Theme = isDarkThemeOn ? .dark : .light
        DependencyInjection.themeUpdater.updateApplicationWithTheme(newTheme: currentTheme)
    }
    
}
