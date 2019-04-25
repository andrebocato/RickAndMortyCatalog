//
//  CharacterResponse.swift
//  RickAndMortyCatalog
//
//  Created by Andre Sanches Bocato on 09/04/19.
//  Copyright © 2019 Andre Sanches Bocato. All rights reserved.
//

import Foundation

struct RMCharacter: Codable {
    /// The id of the character.
    let id: Int
    /// The name of the character.
    let name: String
    /// The status of the character ('Alive', 'Dead' or 'unknown').
    let status: String
    /// The species of the character.
    let species: String
    /// The type or subspecies of the character.
    let type: String
    /// The gender of the character ('Female', 'Male', 'Genderless' or 'unknown').
    let gender: String
    /// Name and link to the character's origin location.
    let origin: RMCharacterOrigin
    /// Name and link to the character's last known location endpoint.
    let location: RMCharacterLocation
    /// Link to the character's image. Images are 300x300px and most are medium shots or portraits. They are intended to be used as avatars.
    let image: String
    /// List of episodes in which this character appeared.
    let episode: [String]
    /// Link to the character's own URL endpoint.
    let url: String
    /// Time at which the character was created in the database.
    let created: String
}

extension RMCharacter: Equatable {
    
    static func == (lhs: RMCharacter, rhs: RMCharacter) -> Bool {
        return lhs.id == rhs.id
    }
    
    public static func != (lhs: RMCharacter, rhs: RMCharacter) -> Bool {
        return lhs.id != rhs.id
    }
    
}
