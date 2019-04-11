//
//  LocationResponse.swift
//  RickAndMortyCatalog
//
//  Created by Andre Sanches Bocato on 09/04/19.
//  Copyright © 2019 Andre Sanches Bocato. All rights reserved.
//

import Foundation

struct RMLocation: Codable {
    let id: Int?                /// The id of the location.
    let name: String?           /// The name of the location.
    let type: String?           /// The type of the location.
    let dimension: String?      /// The dimension in which the location is located.
    let residents: [String]?    /// List of character who have been last seen in the location.
    let url: String?            /// Link to the location's own endpoint.
    let created: String?        /// Time at which the location was created in the database.
}

extension RMLocation {
    
    init(id: Int, name: String, type: String, dimension: String, residents: [String], url: String, created: String) {
        self.id = id
        self.name = name
        self.type = type
        self.dimension = dimension
        self.residents = residents
        self.url = url
        self.created = created
    }
    
}
