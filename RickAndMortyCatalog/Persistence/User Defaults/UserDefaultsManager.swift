//
//  UserDefaultsManager.swift
//  RickAndMortyCatalog
//
//  Created by Andre Sanches Bocato on 14/05/19.
//  Copyright © 2019 Andre Sanches Bocato. All rights reserved.
//

import Foundation

// MARK: - Protocols

protocol UserDefaultsProtocol {
    /// Sets a value to be saved on UserDefaults with a specified key.
    ///
    /// - Parameters:
    ///   - value: Value to be stored.
    ///   - key: Reference key where the value will be stored.
    func setValue(_ value: Any?, forKey key: String)
    
    /// Gets a value stored in a key on UserDefaults.
    ///
    /// - Parameter key: Key reference to the value.
    /// - Returns: The desired value.
    func getValue(forKey key: String) -> Any?
}

// MARK: -

class UserDefaultsImplementation: UserDefaultsProtocol {
    
    // MARK: - Properties
    
    let isDarkThemeKey = "isDarkThemeKey"
    
    // MARK: - Public Functions
    
    
    
    // MARK: - Private Functions
    
    func setValue(_ value: Any?, forKey key: String) {
        UserDefaults.standard.set(value, forKey: key)
    }
    
    func getValue(forKey key: String) -> Any? {
        return UserDefaults.standard.value(forKey: key)
    }
    
}
