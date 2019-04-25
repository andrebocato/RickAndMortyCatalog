//
//  CharactersLogicController.swift
//  RickAndMortyCatalog
//
//  Created by Eduardo Sanches Bocato on 25/04/19.
//  Copyright © 2019 Andre Sanches Bocato. All rights reserved.
//

import Foundation

class CharactersLogicController {
    
    // MARK: - Public Properties
    
    /// Delegate to communicate important events from the logicController
    weak var delegate: CharactersLogicControllerDelegate?
    
    /// Returns the number of fetched characters
    var numberOfCharacters: Int {
        return characters.count
    }
    
    // MARK: - Dependencies
    
    private let service: RMCharactersServiceProtocol
    
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
    private var canFetchNextPage: Bool {
        return charactersResponseInfo?.next != nil && currentPage < totalPages
    }
    
    // MARK: - Initialization
    
    init(service: RMCharactersServiceProtocol) {
        self.service = service
    }
    
    // MARK: - Public Functions
    
    /// Gets the character object for each row
    ///
    /// - Parameter row: the row
    /// - Returns: an RMCharacter
    func characterData(for row: Int) -> RMCharacter {
        return characters[row]
    }
    
    /// Fetches characters from the Network
    func loadCharacters() {
        currentPage = 1
        delegate?.stateDidChange(.loadingCharacters(true))
        fetchCharacters(forPage: currentPage) { [weak self] in
            self?.delegate?.stateDidChange(.loadingCharacters(false))
        }
    }
    
    func loadNextCharactersPage() {
        if canFetchNextPage {
            currentPage += 1
            delegate?.stateDidChange(.loadingNextPage(true))
            fetchCharacters(forPage: currentPage) { [weak self] in
                self?.delegate?.stateDidChange(.loadingNextPage(false))
            }
        }
    }
    
    // MARK: - Private Functions
    
    private func fetchCharacters(forPage page: Int, onCompletion completion: @escaping () -> ()) {
        
        service.getAllCharacters(onPage: page) { [weak self] (result) in
            
            completion()
            
            switch result {
            case .success(let response): self?.handleFetchCharactersSuccessResponse(response)
            case .failure(let error):
                self?.delegate?.stateDidChange(.serviceError(error))
            }
            
        }
        
    }
    
    // MARK: - fetchCharacters() Handlers
    
    private func handleFetchCharactersSuccessResponse(_ response: RMCharacterResponse) {
        
        charactersResponseInfo = response.info
        
        let newCharacters = response.results.filter { !characters.contains($0) }
        characters.append(contentsOf: newCharacters)
        characters.sort(by: { (c1, c2) -> Bool in
            return c1.id < c2.id
        })
        
        delegate?.charactersListDidUpdate()
    }
    
}
