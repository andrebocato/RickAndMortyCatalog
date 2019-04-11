//
//  Origin.swift
//  RickAndMortyCatalog
//
//  Created by Andre Sanches Bocato on 09/04/19.
//  Copyright © 2019 Andre Sanches Bocato. All rights reserved.
//

import Foundation

struct RMCharacterOrigin: Codable {
    let name: String?
    let url: String?
}

extension RMCharacterOrigin {
    
    init(name: String, url: String) {
        self.name = name
        self.url = url
    }
    
}
