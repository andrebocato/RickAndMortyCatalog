//
//  CharacterResponse.swift
//  RickAndMortyCatalog
//
//  Created by Andre Sanches Bocato on 09/04/19.
//  Copyright © 2019 Andre Sanches Bocato. All rights reserved.
//

import Foundation

struct RMCharacter: Codable {
    let id: Int?                        /// The id of the character.
    let name: String?                   /// The name of the character.
    let status: String?                 /// The status of the character ('Alive', 'Dead' or 'unknown').
    let species: String?                /// The species of the character.
    let type: String?                   /// The type or subspecies of the character.
    let gender: String?                 /// The gender of the character ('Female', 'Male', 'Genderless' or 'unknown').
    let origin: RMCharacterOrigin?      /// Name and link to the character's origin location.
    let location: RMCharacterLocation?  /// Name and link to the character's last known location endpoint.
    let image: String?                  /// Link to the character's image. Images are 300x300px and most are medium shots or portraits. They are intended to be used as avatars.
    let episode: [String]?              /// List of episodes in which this character appeared.
    let url: String?                    /// Link to the character's own URL endpoint.
    let created: String?                /// Time at which the character was created in the database.
}

extension RMCharacter {

    init(id: Int, name: String){
        self.id = id
        self.name = name
    }
    
}
