//
//  UserDefaultsManager.swift
//  RickAndMortyCatalog
//
//  Created by Andre Sanches Bocato on 14/05/19.
//  Copyright © 2019 Andre Sanches Bocato. All rights reserved.
//

import Foundation

// MARK: - Protocols

class UserDefaultsManager {
    
    // MARK: - Private Properties
    
    private let isDarkThemeOnKey = "isDarkThemeOnKey"

    // MARK: - Public Functions
    
    public func setDarkThemeOn(_ isOn: Bool) {
        UserDefaults.standard.set(isOn, forKey: isDarkThemeOnKey)
    }
    
    public func isDarkThemeOn() -> Bool {
        return UserDefaults.standard.bool(forKey: isDarkThemeOnKey)
    }

}
