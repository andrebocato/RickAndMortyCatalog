//
//  RMCharacterResponse.swift
//  RickAndMortyCatalog
//
//  Created by Andre Sanches Bocato on 22/04/19.
//  Copyright © 2019 Andre Sanches Bocato. All rights reserved.
//

import Foundation

struct RMCharacterResponse: Codable {
    let info: RMCharacterInfo
    let results: [RMCharacter]
}
