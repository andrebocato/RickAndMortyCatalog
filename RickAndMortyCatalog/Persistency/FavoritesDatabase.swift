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
    
    /// <#Description#>
    ///
    /// - Parameters:
    ///   - rmCharacter: <#rmCharacter description#>
    ///   - imageData: <#imageData description#>
    /// - Returns: <#return value description#>
    /// - Throws: <#throws value description#>
    func createOrUpdateFavorite(rmCharacter: RMCharacter, imageData: Data) throws
    
    /// <#Description#>
    ///
    /// - Parameter id: <#id description#>
    /// - Returns: <#return value description#>
    /// - Throws: <#throws value description#>
    func fetchFavoriteWithID(_ id: Int) throws -> FavoriteCharacter?
    
    /// <#Description#>
    ///
    /// - Returns: <#return value description#>
    /// - Throws: <#throws value description#>
    func fetchAllFavorites() throws -> [FavoriteCharacter]
    
    /// <#Description#>
    ///
    /// - Parameter id: <#id description#>
    /// - Throws: <#throws value description#>
    func deleteFavorite(withID id: Int) throws
    
    /// <#Description#>
    ///
    /// - Throws: <#throws value description#>
    func deleteAll() throws
}

class FavoritesDatabase: FavoritesDatabaseProtocol {

    private let realm: Realm

    init(realm: Realm) {
        self.realm = realm
    }

    func createOrUpdateFavorite(rmCharacter: RMCharacter, imageData: Data) throws {
        let objectToPersist = RealmFavoriteCharacter(rmCharacter: rmCharacter, imageData: imageData)
        try realm.write {
            realm.add(objectToPersist, update: true)
        }
    }
    
    func fetchFavoriteWithID(_ id: Int) throws -> FavoriteCharacter? {
        let results = try fetchAllFavorites()
        return results.filter { $0.rmCharacter.id == id }.first
    }
    
    func fetchAllFavorites() throws -> [FavoriteCharacter] {
        return try realm.objects(RealmFavoriteCharacter.self)
            .compactMap({ (realmFavorite) -> FavoriteCharacter? in
                guard let characterData = realmFavorite.rmCharacterData,
                    let imageData = realmFavorite.imageData else { return nil }
                let character = try JSONDecoder().decode(RMCharacter.self, from: characterData)
                return FavoriteCharacter(rmCharacter: character, imageData: imageData)
            })
            .sorted(by: { (f1, f2) -> Bool in
                return f1.rmCharacter.id < f1.rmCharacter.id
            })
    }

    func deleteFavorite(withID id: Int) throws {
        let primaryKey = "\(id)"
        let object = realm.object(ofType: RealmFavoriteCharacter.self, forPrimaryKey: primaryKey)
        if let object = object {
            try realm.write {
                realm.delete(object)
            }
        }
    }

    func deleteAll() throws {
        try realm.write {
            realm.deleteAll()
        }
    }

}
