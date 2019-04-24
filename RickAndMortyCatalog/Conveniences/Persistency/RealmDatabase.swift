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
    
    @objc dynamic var id: String = UUID().uuidString
    @objc dynamic var rmCharacterData: Data? = nil
    @objc dynamic var imageData: Data? = nil
    
    var rmCharacter: RMCharacter? {
        guard let data = rmCharacterData,
            let character = try? JSONDecoder().decode(RMCharacter.self, from: data) else { return nil }
        return character
    }
    
    // MARK: - Initialization
    
    /// Inializes a favorite from an RMCharacter and its image
    ///
    /// - Parameters:
    ///   - character: an RMCharacter
    ///   - imageData: a character image
    convenience init(rmCharacter: RMCharacter, imageData: Data) {
        self.init()
        self.rmCharacterData = try? JSONEncoder().encode(rmCharacter)
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
        return results.filter { $0.rmCharacter?.id == id }.first
    }
    
    func fetchAllFavorites() -> [FavoriteCharacter] {
        return realm.objects(FavoriteCharacter.self)
            .sorted(by: { (f1, f2) -> Bool in
                guard let rm1 = f1.rmCharacter, let rm2 = f1.rmCharacter else { return false }
                return rm1.id < rm2.id
            })
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
