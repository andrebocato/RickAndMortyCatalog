//
//  DetailFields.swift
//  RickAndMortyCatalog
//
//  Created by Andre Sanches Bocato on 28/05/19.
//  Copyright © 2019 Andre Sanches Bocato. All rights reserved.
//

import Foundation

enum DetailFields: Int, CaseIterable{
    case id
    case name
    case status
    case species
    case type
    case gender
    case origin
    case location
    
    var stringValue: String {
        switch self {
        case .id: return "ID"
        case .name: return "NAME"
        case .status: return "STATUS"
        case .species: return "SPECIES"
        case .type: return "TYPE"
        case .gender: return "GENDER"
        case .origin: return "ORIGIN"
        case .location: return "LOCATION"
        }
    }
    
    var indexPath: IndexPath {
        return IndexPath(item: self.rawValue, section: 0)
    }
}
