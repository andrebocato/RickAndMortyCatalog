//
//  SerializationError.swift
//  RickAndMortyCatalog
//
//  Created by Andre Sanches Bocato on 09/04/19.
//  Copyright © 2019 Andre Sanches Bocato. All rights reserved.
//

import Foundation

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
