//
//  LocationResponse.swift
//  RickAndMortyCatalog
//
//  Created by Andre Sanches Bocato on 09/04/19.
//  Copyright © 2019 Andre Sanches Bocato. All rights reserved.
//

import Foundation

struct RMLocation: Codable {
    var id: Int?                /// The id of the location.
    var name: String?           /// The name of the location.
    var type: String?           /// The type of the location.
    var dimension: String?      /// The dimension in which the location is located.
    var residents: [String]?    /// List of character who have been last seen in the location.
    var url: String?            /// Link to the location's own endpoint.
    var created: String?        /// Time at which the location was created in the database.
}
