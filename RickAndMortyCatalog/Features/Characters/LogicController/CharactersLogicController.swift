//
//  CharactersLogicController.swift
//  RickAndMortyCatalog
//
//  Created by Andre Sanches Bocato on 25/04/19.
//  Copyright © 2019 Andre Sanches Bocato. All rights reserved.
//

import Foundation

class CharactersLogicController {
    
    // MARK: - Public Properties
    
    /// Delegate to communicate important events from the logicController.
    weak var delegate: CharactersLogicControllerDelegate?
    
    /// Returns the number of fetched characters.
    var numberOfCharacters: Int {
        return characters.count
    }
    
    // MARK: - Dependencies
    
    private let service: RMCharactersServiceProtocol
    private let modelControllerFactory: ModelControllersFactoryProtocol
    
    // MARK: - Private Properties
    
    private var currentPage = 1
    private var totalPages: Int {
        return charactersResponseInfo?.pages ?? 1
    }
    private var characters: [RMCharacter] = [] {
        didSet {
            delegate?.charactersListDidUpdate()
        }
    }
    private var charactersResponseInfo: RMCharacterInfo?
    private var canGetNextPage: Bool {
        return charactersResponseInfo?.next != nil && currentPage < totalPages
    }
    
    // MARK: - Initialization
    
    init(service: RMCharactersServiceProtocol,
         modelControllerFactory: ModelControllersFactoryProtocol) {
        self.service = service
        self.modelControllerFactory = modelControllerFactory
    }
    
    // MARK: - Public Functions
    
    /// Defines the modelController for a row.
    ///
    /// - Parameter row: The row to be worked on.
    /// - Returns: The modelController to the model on the specified row.
    func modelController(for row: Int) -> RMCharacterModelController {
        return modelControllerFactory.createRMCharacterModelController(character: characters[row])
    }
    
    /// Fetches characters from the Network.
    func loadCharacters() {
        currentPage = 1
        delegate?.stateDidChange(.loadingCharacters(true))
        getCharacters(forPage: currentPage) { [weak self] in
            self?.delegate?.stateDidChange(.loadingCharacters(false))
        }
    }
    
    /// Loads the next page of characters.
    func loadNextCharactersPage() {
        if canGetNextPage {
            currentPage += 1
            delegate?.stateDidChange(.loadingNextPage(true))
            getCharacters(forPage: currentPage) { [weak self] in
                self?.delegate?.stateDidChange(.loadingNextPage(false))
            }
        }
    }
    
    // MARK: - Private Functions
    
    /// Gets an array of characters from the Network.
    ///
    /// - Parameters:
    ///   - page: Number of the desired page.
    ///   - completion: Returns a response on success or an error on failure.
    private func getCharacters(forPage page: Int,
                               onCompletion completion: @escaping () -> ()) {
        
        service.getAllCharacters(onPage: page) { [weak self] (result) in
            
            completion()
            
            switch result {
            case .success(let response):
                self?.handleGetCharactersSuccessResponse(response)
                
            case .failure(let error):
                self?.delegate?.stateDidChange(.serviceError(error))
            }
        }
    }
    
    // MARK: - getCharacters() Handlers
    
    /// Handles the response when successful.
    ///
    /// - Parameter response: Success response to be handled.
    private func handleGetCharactersSuccessResponse(_ response: RMCharacterResponse) {
        charactersResponseInfo = response.info
        
        let newCharacters = response.results.filter { !characters.contains($0) }
        characters.append(contentsOf: newCharacters)
        characters.sort(by: { $0.id < $1.id })
        
        delegate?.charactersListDidUpdate()
    }
    
}
