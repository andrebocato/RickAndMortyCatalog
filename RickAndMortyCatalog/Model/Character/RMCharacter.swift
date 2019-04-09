//
//  CharacterResponse.swift
//  RickAndMortyCatalog
//
//  Created by Andre Sanches Bocato on 09/04/19.
//  Copyright © 2019 Andre Sanches Bocato. All rights reserved.
//

import Foundation

struct RMCharacter: Codable {
    var id: Int?                        /// The id of the character.
    var name: String?                   /// The name of the character.
    var status: String?                 /// The status of the character ('Alive', 'Dead' or 'unknown').
    var species: String?                /// The species of the character.
    var type: String?                   /// The type or subspecies of the character.
    var gender: String?                 /// The gender of the character ('Female', 'Male', 'Genderless' or 'unknown').
    var origin: RMCharacterOrigin?      /// Name and link to the character's origin location.
    var location: RMCharacterLocation?  /// Name and link to the character's last known location endpoint.
    var image: String?                  /// Link to the character's image. Images are 300x300px and most are medium shots or portraits. They are intended to be used as avatars.
    var episode: [String]?              /// List of episodes in which this character appeared.
    var url: String?                    /// Link to the character's own URL endpoint.
    var created: String?                /// Time at which the character was created in the database.
}
