//
//  RMCharacterModelController.swift
//  RickAndMortyCatalog
//
//  Created by Eduardo Sanches Bocato on 25/04/19.
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
    
    /// Checks if this character is present on the favorites database
    var isFavorite: Bool {
        let favorite = try? favoritesDatabase.fetchFavoriteWithID(character.id)
        return favorite != nil
    }
    
    // Returns the RMCharacterData
    let character: RMCharacter
    
    /// Delegate to communicate with the model holder
    weak var delegate: RMCharacterModelControllerDelegate?
    
    // MARK: Initilizer
    
    /// <#Description#>
    ///
    /// - Parameters:
    ///   - character: <#character description#>
    ///   - service: <#service description#>
    ///   - favoritesDatabase: <#favoritesDatabase description#>
    init(character: RMCharacter,
         service: ImageServiceProtocol,
         favoritesDatabase: FavoritesDatabaseProtocol) {
        self.character = character
        self.service = service
        self.favoritesDatabase = favoritesDatabase
    }
    
    // MARK: Public Functions
    
    /// Fetches da image data
    ///
    /// - Parameter completion: returns the image data from an asyncro
    func fetchImageData(completion: @escaping (Data) -> Void) {
        if isFavorite {
            fetchCharacterImageFromPersistency(completion: completion)
        } else {
            fetchCharacterImageFromImageService(completion: completion)
        }
    }
    
    /// <#Description#>
    func cancelImageRequest() {
        requestToken?.cancel()
    }
    
    /// <#Description#>
    ///
    /// - Parameter onSuccess: <#onSuccess description#>
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
    
    /// <#Description#>
    ///
    /// - Parameter onSuccess: <#onSuccess description#>
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
    
    private func fetchCharacterImageFromPersistency(completion: @escaping (Data) -> Void) {
        guard let favorite = try? favoritesDatabase.fetchFavoriteWithID(character.id) else {
            // @TODO: return placeholder ?
            return
        }
        imageData = favorite.imageData
        completion(favorite.imageData)
    }
    
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
