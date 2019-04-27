//
//  RealmDatabase.swift
//  RickAndMortyCatalog
//
//  Created by Andre Sanches Bocato on 24/04/19.
//  Copyright © 2019 Andre Sanches Bocato. All rights reserved.
//

import Foundation
import RealmSwift

protocol FavoritesDatabaseProtocol { // @TODO: Document
    
    /// Creates a new favorite or updates its data on the database.
    ///
    /// - Parameters:
    ///   - rmCharacter: A RMCharacter.
    ///   - imageData: The character's image data.
    /// - Returns: Void.
    /// - Throws: An error from the persistence.
    func createOrUpdateFavorite(rmCharacter: RMCharacter, imageData: Data) throws
    
    /// Fetches an object from the favorites database.
    ///
    /// - Parameter id: The id from the character to be retrieved.
    /// - Returns: A FavoriteCharacter.
    /// - Throws: An error from the persistence.
    func fetchFavoriteWithID(_ id: Int) throws -> FavoriteCharacter?
    
    /// Fetches all objects from the favorites database.
    ///
    /// - Returns: An array of FavoriteCharacters.
    /// - Throws: An error from the persistence.
    func fetchAllFavorites() throws -> [FavoriteCharacter]
    
    /// Deletes a specified object from the favorites database.
    ///
    /// - Parameter id: The id from the character to be deleted.
    /// - Throws: An error from the persistence.
    func deleteFavorite(withID id: Int) throws
    
    /// Deletes all favorite characters in the database.
    ///
    /// - Throws: An error from the persistence.
    func deleteAll() throws
}

class FavoritesDatabase: FavoritesDatabaseProtocol {

    func createOrUpdateFavorite(rmCharacter: RMCharacter,
                                imageData: Data) throws {
        
        let realm = try Realm()
        
        let objectToPersist = RealmFavoriteCharacter(rmCharacter: rmCharacter, imageData: imageData)
        objectToPersist.id = "\(rmCharacter.id)"
        try realm.write {
            realm.add(objectToPersist, update: true)
        }
        
    }
    
    func fetchFavoriteWithID(_ id: Int) throws -> FavoriteCharacter? {
        let results = try fetchAllFavorites()
        return results.filter { $0.rmCharacter.id == id }.first
    }
    
    func fetchAllFavorites() throws -> [FavoriteCharacter] {
        
        let realm = try Realm()
        
        return try realm.objects(RealmFavoriteCharacter.self)
            .compactMap({ (realmFavorite) -> FavoriteCharacter? in
                guard let characterData = realmFavorite.rmCharacterData,
                    let imageData = realmFavorite.imageData else { return nil }
                
                let character = try JSONDecoder().decode(RMCharacter.self, from: characterData)
                return FavoriteCharacter(rmCharacter: character, imageData: imageData)
            })
            .sorted(by: { (favorite1, favorite2) -> Bool in
                return favorite1.rmCharacter.id < favorite2.rmCharacter.id
            })
        
    }

    func deleteFavorite(withID id: Int) throws {
        
        let realm = try Realm()
        
        let primaryKey = "\(id)"
        let object = realm.object(ofType: RealmFavoriteCharacter.self, forPrimaryKey: primaryKey)
        if let object = object {
            try realm.write {
                realm.delete(object)
            }
        }
        
    }

    func deleteAll() throws {
        
        let realm = try Realm()
        
        try realm.write {
            realm.deleteAll()
        }
        
    }

}
