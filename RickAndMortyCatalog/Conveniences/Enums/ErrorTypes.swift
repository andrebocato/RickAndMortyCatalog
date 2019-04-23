//
//  ErrorTypes.swift
//  RickAndMortyCatalog
//
//  Created by Andre Sanches Bocato on 09/04/19.
//  Copyright © 2019 Andre Sanches Bocato. All rights reserved.
//

import Foundation

// MARK: - Persistence Errors

enum PersistenceError: Error {
    case unknown
    case unexpected
    case failedToFind
    case failedToPersist
    case failedToFetchData
    case existingObject
    case failedToDelete
    case nothingToDelete
    
    var code: Int {
        switch self {
        case .unknown:
            return 20
        case .unexpected:
            return 21
        case .failedToFind:
            return 22
        case .failedToPersist:
            return 23
        case .failedToFetchData:
            return 24
        case .existingObject:
            return 25
        case .failedToDelete:
            return 26
        case .nothingToDelete:
            return 27
        }
    }
    
    var localizedDescription: String {
        switch self {
        case .unknown:
            return "An unknown error has occurred while persisting data."
        case .unexpected:
            return "An unexpected error has occurred while persisting data."
        case .failedToFind:
            return "Could not find persisted object."
        case .failedToPersist:
            return "Could not persist object."
        case .failedToFetchData:
            return "Could not fetch persisted data."
        case .existingObject:
            return "Object already exists in database."
        case .failedToDelete:
            return "Could not delete object from local database."
        case .nothingToDelete:
            return "No objects to delete."
        }
    }
}
// MARK: - Serialization Errors

enum SerializationError: Error {
    case unknown
    case unexpected
    case failedToSerialize
    case failedToDeserialize
    
    var code: Int {
        switch self {
        case .unknown:
            return 30
        case .unexpected:
            return 31
        case .failedToSerialize:
            return 32
        case .failedToDeserialize:
            return 33
        }
    }
    
    var localizedDescrption: String {
        switch self {
        case .unknown:
            return "An unknown error has occcurred in encoding."
        case .unexpected:
            return "An unexpected error has occcurred in encoding."
        case .failedToSerialize:
            return "Could not serialize object."
        case .failedToDeserialize:
            return "Could not deserialize data."
        }
    }
}
