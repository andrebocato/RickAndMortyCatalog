//
//  RMEpisode.swift
//  RickAndMortyCatalog
//
//  Created by Andre Sanches Bocato on 15/04/19.
//  Copyright © 2019 Andre Sanches Bocato. All rights reserved.
//

import Foundation

struct RMEpisode: Codable {
    let id: Int?                /// The id of the episode.
    let name: String?           /// The name of the episode.
    let airDate: String?        /// The air date of the episode.
    let episode: String?        /// The code of the episode.
    let characters: [String]?   /// List of characters who have been seen in the episode.
    let url: String?            /// Link to the episode's own endpoint.
    let created: String?        /// Time at which the episode was created in the database.
}

enum CodingKeys: String {
    case id, name, episode, characters, url, created
    case airDate = "air_date"
}

extension RMEpisode {
    
    init(id: Int, name: String, airDate: String, episode: String, characters: [String], url: String, created: String) {
        self.id = id
        self.name = name
        self.airDate = airDate
        self.episode = episode
        self.characters = characters
        self.url = url
        self.created = created
    }
    
}
