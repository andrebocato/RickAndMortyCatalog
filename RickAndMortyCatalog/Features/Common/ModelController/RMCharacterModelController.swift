//
//  RMCharacterModelController.swift
//  RickAndMortyCatalog
//
//  Created by Andre Sanches Bocato on 25/04/19.
//  Copyright © 2019 Andre Sanches Bocato. All rights reserved.
//

import Foundation

class RMCharacterModelController: RMCharacterImageFetcherProtocol {
    
    // MARK: - Dependencies
    
    private let service: ImageServiceProtocol
    private var favoritesDatabase: FavoritesDatabaseProtocol
    
    // MARK: - Private Properties
    
    private var requestToken: URLRequestToken?
    private var imageData: Data?
    private var databaseObjectObservationToken: FavoritesDatabaseObservationToken?
    
    // MARK: - Public Properties
    
    /// Checks if this character is present on the favorites database.
    private(set) var isFavorite: Bool = false {
        didSet {
            delegate?.stateDidChange(.favoritePropertyChanged(isFavorite))
        }
    }
    
    // Returns the RMCharacter data
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
        setupIsFavoriteValue()
    }
    
    // MARK: - Lifecycle
    
    deinit {
        databaseObjectObservationToken?.invalidate()
    }
    
    // MARK: - Public Functions
    
    /// Fetches the image data from persistence or downloads it.
    ///
    /// - Parameter completion: Returns the image data asynchronously.
    public func fetchImageData(completion: @escaping (Data) -> Void) {
        isFavorite ? fetchCharacterImageFromPersistence(completion: completion) : fetchCharacterImageFromImageService(completion: completion)
    }
    
    /// Cancels the network request for image data.
    public func cancelImageRequest() {
        requestToken?.cancel()
    }
    
    /// Adds the model to the favorites database.
    public func addToFavorites() {
        guard let imageData = imageData else {
            delegate?.stateDidChange(.businessError(.couldNotAddToFavorites))
            return
        }
        
        do {
            try favoritesDatabase.createOrUpdateFavorite(rmCharacter: character, imageData: imageData)
            isFavorite = true
            
        } catch {
            debugPrint(error)
            delegate?.stateDidChange(.businessError(.couldNotAddToFavorites))
        }
    }
    
    /// Removes the model from the favorites database.
    public func removeFromFavorites() {
        do {
            try favoritesDatabase.deleteFavorite(withID: character.id)
            isFavorite = false
            
        } catch {
            debugPrint(error)
            delegate?.stateDidChange(.businessError(.couldNotRemoveFromFavorites))
        }
    }
    
    // MARK: - Private Functions
    
    private func setupIsFavoriteValue() {
        let favorite = try? favoritesDatabase.fetchFavoriteWithID(character.id)
        isFavorite = favorite != nil
        databaseObjectObservationToken = try? favoritesDatabase.addObserverForCharacterWithID(character.id) { [weak self] (change) in
            switch change {
            case .deleted:
                self?.isFavorite = false
            default: return
            }
        }
    }
    
    /// Tries to fetch an image data from the persistence layer.
    ///
    /// - Parameter completion: Executed after fetching image data.
    private func fetchCharacterImageFromPersistence(completion: @escaping (Data) -> Void) {
        guard let favorite = try? favoritesDatabase.fetchFavoriteWithID(character.id) else { return }
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
            self?.delegate?.stateDidChange(.loadingImage(false))
            
            switch result {
            case .success(let data):
                self?.imageData = data
                completion(data)
                
            case .failure(let error):
                debugPrint(error)
            }
        }
    }
    
}
