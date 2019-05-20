//
//  ColorThemes.swift
//  RickAndMortyCatalog
//
//  Created by Andre Sanches Bocato on 14/05/19.
//  Copyright © 2019 Andre Sanches Bocato. All rights reserved.
//

import UIKit

// MARK: - Protocols

/// Establishes theme observer setting up and tearing down.
protocol ThemeObserving {
    /// Sets up an observer for theme changes.
    func setupThemeObserver()
    
    /// Tears down an observer for theme changes;
    func tearDownThemeObserver()
}

/// Allows the class to update its theme.
protocol ThemeUpdaterProtocol {
    /// Updates the application with a selected theme.
    ///
    /// - Parameter newTheme: The new theme to be applied.
    func updateApplicationWithTheme(newTheme: ThemeType)
}

/// Allows the object to have a theme.
protocol Themeable {
    /// Applies a selected theme to the object.
    ///
    /// - Parameter theme: The theme to be applied.
    func apply(theme: ThemeType)
}

// MARK: - Theme Updater

class ThemeUpdater: ThemeUpdaterProtocol {
    
    func updateApplicationWithTheme(newTheme: ThemeType) {
        NotificationCenter.default.post(name: .applicationThemeDidChange, object: newTheme)
    }
    
}

// MARK: - Extensions

extension ThemeObserving where Self: Themeable & NSObjectProtocol {
    
    // MARK: - Theme Observing functions
    
    func setupThemeObserver() {
        NotificationCenter.default.addObserver(forName: .applicationThemeDidChange, object: nil, queue: nil) { [weak self] (notification) in
            self?.themeDidChangeWithNotification(notification)
        }
    }
    
    func tearDownThemeObserver() {
        NotificationCenter.default.removeObserver(self, name: .applicationThemeDidChange, object: nil)
    }
    
    // MARK: - Private Functions
    
    private func themeDidChangeWithNotification(_ notification: Notification) {
        guard let object = notification.object,
            let newTheme = object as? Theme else { return }
        apply(theme: newTheme)
    }
    
}
