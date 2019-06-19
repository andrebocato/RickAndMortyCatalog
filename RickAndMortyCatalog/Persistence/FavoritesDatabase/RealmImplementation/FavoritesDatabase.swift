//
//  RealmDatabase.swift
//  RickAndMortyCatalog
//
//  Created by Andre Sanches Bocato on 24/04/19.
//  Copyright © 2019 Andre Sanches Bocato. All rights reserved.
//

import Foundation
import RealmSwift

class FavoritesDatabase: FavoritesDatabaseProtocol {
    
    // MARK: Public Methods
    
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
                guard let characterData = realmFavorite.rmCharacterData, let imageData = realmFavorite.imageData else { return nil }
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
    
    func addObserverForCharacterWithID(_ id: Int, onChange: @escaping (_ change: FavoriteDatabaseObjectChange) -> Void) throws -> FavoritesDatabaseObservationToken? {
        
        let realm = try Realm()
        
        let primaryKey = "\(id)"
        
        guard let result = realm.object(ofType: RealmFavoriteCharacter.self, forPrimaryKey: primaryKey) else { return nil }
        
        let token = result.observe { (change) in
            switch change {
            case .change:
                onChange(.updated)
                
            case .deleted:
                onChange(.deleted)
                
            default:
                return
            }
        }
        
        return RealmObjectObservationToken(realmNotificationToken: token)
    }
    
}
