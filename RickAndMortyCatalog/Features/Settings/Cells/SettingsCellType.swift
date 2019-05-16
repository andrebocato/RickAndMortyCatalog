//
//  SettingsCellType.swift
//  RickAndMortyCatalog
//
//  Created by Andre Sanches Bocato on 16/05/19.
//  Copyright © 2019 Andre Sanches Bocato. All rights reserved.
//

import Foundation

enum SettingsCellType {
    
    case deleteAll
    case `switch`
    case githubRepo
    case apiDocumentation
    
    init?(section: Int, row: Int) {
        switch (section, row) {
        case (0, 0): self = .deleteAll
        case (1, 0): self = .switch
        case (2, 0): self = .githubRepo
        case (2, 1): self = .apiDocumentation
        default: return nil
        }
    }
    
}
