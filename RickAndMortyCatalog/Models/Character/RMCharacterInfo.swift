//
//  RMCharacterInfo.swift
//  RickAndMortyCatalog
//
//  Created by Eduardo Sanches Bocato on 22/04/19.
//  Copyright © 2019 Andre Sanches Bocato. All rights reserved.
//

import Foundation

struct RMCharacterInfo: Codable {
    let count: Int
    let pages: Int
    let next: String?
    let prev: String?
}
