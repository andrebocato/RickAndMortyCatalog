//
//  Filters.swift
//  RickAndMortyCatalog
//
//  Created by Andre Sanches Bocato on 27/05/19.
//  Copyright © 2019 Andre Sanches Bocato. All rights reserved.
//

import Foundation

enum StatusFilter: Int, CaseIterable {
    case all
    case alive
    case dead
    case unknown
    
    var stringValue: String {
        switch self {
        case .all: return "All"
        case .alive: return "Alive"
        case .dead: return "Dead"
        case .unknown: return "unknown"
        }
    }
}
