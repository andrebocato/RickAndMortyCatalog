//
//  CharacterLocation.swift
//  RickAndMortyCatalog
//
//  Created by Andre Sanches Bocato on 09/04/19.
//  Copyright © 2019 Andre Sanches Bocato. All rights reserved.
//

import Foundation

struct RMCharacterLocation: Codable {
    let name: String?
    let url: String?
}

extension RMCharacterLocation {
    
    init(name: String, url: String) {
        self.name = name
        self.url = url
    }
    
}
