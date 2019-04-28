//
//  FavoritesDatabaseProtocol.swift
//  RickAndMortyCatalog
//
//  Created by Andre Sanches Bocato on 27/04/19.
//  Copyright © 2019 Andre Sanches Bocato. All rights reserved.
//

import Foundation

protocol FavoritesDatabaseProtocol {

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
    
    /// Adds an observer for the character with the ID
    ///
    /// - Parameters:
    ///   - id: The characters ID.
    ///   - onChange: Callback for the observations.
    /// - Returns: A change representation.
    /// - Throws: An error if the observation could not be set on the object.
    func addObserverForCharacterWithID(_ id: Int, onChange: @escaping (_ change: FavoriteDatabaseObjectChange) -> Void) throws -> FavoritesDatabaseObservationToken?
    
}


