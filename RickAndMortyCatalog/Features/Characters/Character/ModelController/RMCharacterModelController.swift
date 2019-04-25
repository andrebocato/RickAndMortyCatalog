//
//  RMCharacterModelController.swift
//  RickAndMortyCatalog
//
//  Created by Andre Sanches Bocato on 25/04/19.
//  Copyright © 2019 Andre Sanches Bocato. All rights reserved.
//

import Foundation

class RMCharacterModelController {
    
    // MARK: - Dependencies
    
    private let service: ImageServiceProtocol
    private let favoritesDatabase: FavoritesDatabaseProtocol
    
    // MARK: - Private Properties
    
    private var requestToken: URLRequestToken?
    private var imageData: Data?
    
    // MARK: - Public Properties
    
    /// Checks if this character is present on the favorites database.
    var isFavorite: Bool {
        let favorite = try? favoritesDatabase.fetchFavoriteWithID(character.id)
        return favorite != nil
    }
    
    // Returns the RMCharacterData
    let character: RMCharacter
    
    /// Delegate to communicate with the model holder.
    weak var delegate: RMCharacterModelControllerDelegate?
    
    // MARK: - Initialization
    
    /// Initializer.
    ///
    /// - Parameters:
    ///   - character: A RMCharacter.
    ///   - service: The networking service for getting image data.
    ///   - favoritesDatabase: The favorite characters database.
    init(character: RMCharacter,
         service: ImageServiceProtocol,
         favoritesDatabase: FavoritesDatabaseProtocol) {
        self.character = character
        self.service = service
        self.favoritesDatabase = favoritesDatabase
    }
    
    // MARK: Public Functions
    
    /// Fetches the image data from persistence or downloads it.
    ///
    /// - Parameter completion: Returns the image data asynchronously.
    func fetchImageData(completion: @escaping (Data) -> Void) {
        if isFavorite {
            fetchCharacterImageFromPersistence(completion: completion)
        } else {
            fetchCharacterImageFromImageService(completion: completion)
        }
    }
    
    /// Cancels the network request for image data.
    func cancelImageRequest() {
        requestToken?.cancel()
    }
    
    /// Adds the model to the favorites database.
    ///
    /// - Parameter onSuccess: To be executed after successfully adding to favorites.
    func addToFavorites(onSuccess: (() -> Void)? = nil) {
        guard let imageData = imageData else {
            delegate?.stateDidChange(.businessError(.couldNotAddToFavorites))
            return
        }
        
        do {
            try favoritesDatabase.createOrUpdateFavorite(rmCharacter: character, imageData: imageData)
            onSuccess?()
        } catch {
            debugPrint(error)
            delegate?.stateDidChange(.businessError(.couldNotAddToFavorites))
        }
    }
    
    /// Removes the model from the favorites database.
    ///
    /// - Parameter onSuccess: To be executed after successfully removing from favorites.
    func removeFromFavorites(onSuccess: (() -> Void)? = nil) {
        do {
            try favoritesDatabase.deleteFavorite(withID: character.id)
            onSuccess?()
        } catch {
            debugPrint(error)
            delegate?.stateDidChange(.businessError(.couldNotRemoteFromFavorites))
        }
    }
    
    // MARK: - Private Functions
    
    /// Tries to fetch an image data from the persistence layer.
    ///
    /// - Parameter completion: Executed after fetching image data.
    private func fetchCharacterImageFromPersistence(completion: @escaping (Data) -> Void) {
        guard let favorite = try? favoritesDatabase.fetchFavoriteWithID(character.id) else {
            // @TODO: return placeholder ?
            return
        }
        imageData = favorite.imageData
        completion(favorite.imageData)
    }
    
    /// Gets an image data from the network.
    ///
    /// - Parameter completion: Returns image data on success and and error on failure.
    private func fetchCharacterImageFromImageService(completion: @escaping (Data) -> Void) {
        
        delegate?.stateDidChange(.loadingImage(true))
        
        let imageURL = character.image
        requestToken = service.getImageDataFromURL(imageURL) { [weak self] (result) in
            
            self?.delegate?.stateDidChange(.loadingImage(true))
            
            switch result {
            case .success(let data):
                self?.imageData = data
                completion(data)
            case .failure(let error):
                debugPrint(error)
                // @TODO: return placeholder ?
            }
            
        }
    }
    
}
