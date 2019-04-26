//
//  FavoriteCharacter.swift
//  RickAndMortyCatalog
//
//  Created by Andre Sanches Bocato on 25/04/19.
//  Copyright © 2019 Andre Sanches Bocato. All rights reserved.
//

import Foundation
import RealmSwift

class RealmFavoriteCharacter: Object {
    
    // MARK: - Properties
    
    @objc dynamic var id: String = UUID().uuidString
    @objc dynamic var rmCharacterData: Data? = nil
    @objc dynamic var imageData: Data? = nil
    
    // MARK: - Initialization
    
    /// Initializes a favorite from an RMCharacter and its image.
    ///
    /// - Parameters:
    ///   - character: A RMCharacter.
    ///   - imageData: The character's image data.
    convenience init(rmCharacter: RMCharacter,
                     imageData: Data) {
        self.init()
        self.id = "\(rmCharacter.id)"
        self.rmCharacterData = try? JSONEncoder().encode(rmCharacter)
        self.imageData = imageData
    }
    
    // MARK: - Functions
    
    /// Returns this objects primary key.
    ///
    /// - Returns: The primary key.
    override static func primaryKey() -> String? {
        return "id"
    }
    
}
