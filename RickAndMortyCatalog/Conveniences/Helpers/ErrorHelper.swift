//
//  ErrorHelper.swift
//  RickAndMortyCatalog
//
//  Created by Andre Sanches Bocato on 09/04/19.
//  Copyright © 2019 Andre Sanches Bocato. All rights reserved.
//
// @TODO: refactor into a single error function

import Foundation

class ErrorHelper {
    
    // MARK: - Initialization
    
    private init() {}
    
    // MARK: - Functions
    
    /// Displays a service error code and description in the console.
    ///
    /// - Parameter error: Error returned from the action.
    static func logServiceError(_ error: ServiceError?) {
        guard let error = error else { return }
        debugPrint("ERROR CODE: \(error.code).\n" + "ERROR DESCRIPTION: \(error.localizedDescription)")
    }
    
    /// Displays a persistence error code and description in the console.
    ///
    /// - Parameter error: Error returned from the action.
    static func logPersistenceError(_ error: PersistenceError?) {
        guard let error = error else { return }
        debugPrint("ERROR CODE: \(error.code).\n" + "ERROR DESCRIPTION: \(error.localizedDescription)")
    }
    
    /// Displays a serialization error code and description in the console.
    ///
    /// - Parameter error: Error returned from the action.
    static func logSerializationError(_ error: SerializationError?) {
        guard let error = error else { return }
        debugPrint("ERROR CODE: \(error.code).\n" + "ERROR DESCRIPTION: \(error.localizedDescription)")
    }
    
}
