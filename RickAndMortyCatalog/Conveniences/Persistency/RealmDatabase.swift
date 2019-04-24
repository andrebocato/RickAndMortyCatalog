//
//  RealmDatabase.swift
//  RickAndMortyCatalog
//
//  Created by Eduardo Sanches Bocato on 24/04/19.
//  Copyright © 2019 Andre Sanches Bocato. All rights reserved.
//

import Foundation
import RealmSwift

class FavoriteCharacter: Object {
    
    // MARK: - Properties
    
    dynamic var id: String = UUID().uuidString
    dynamic var rmCharacter: RMCharacter? = nil
    dynamic var imageData: Data? = nil
    
    // MARK: - Initialization
    
    /// Inializes a favorite from an RMCharacter and its image
    ///
    /// - Parameters:
    ///   - character: an RMCharacter
    ///   - imageData: a character image
    convenience init(rmCharacter: RMCharacter, imageData: Data) {
        self.init()
        self.id = "\(rmCharacter.id)"
        self.rmCharacter = rmCharacter
        self.imageData = imageData
    }
    
    // MARK: - Functions
    
    /// Returns this objects primary key
    ///
    /// - Returns: the primary key
    override static func primaryKey() -> String? {
        return "id"
    }
    
}

class RealmDatabase {

    private let realm: Realm

    init(realm: Realm) {
        self.realm = realm
    }

    func createOrUpdateFavorite(rmCharacter: RMCharacter, imageData: Data) throws {
        let objectToPersist = FavoriteCharacter(rmCharacter: rmCharacter, imageData: imageData)
        try realm.write {
            realm.add(objectToPersist, update: true)
        }
    }
    
    func fetchFavoriteWithID(_ id: Int) -> FavoriteCharacter? {
        let results = realm.objects(FavoriteCharacter.self)
        return results.filter { $0.id == "\(id)" }.first
    }
    
    func fetchAllFavorites() -> [FavoriteCharacter] {
        return realm.objects(FavoriteCharacter.self).sorted(by: { $0.id < $1.id } )
    }

    func deleteFavorite(withID id: Int) throws {
        let primaryKey = "\(id)"
        let object = realm.object(ofType: FavoriteCharacter.self, forPrimaryKey: primaryKey)
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
