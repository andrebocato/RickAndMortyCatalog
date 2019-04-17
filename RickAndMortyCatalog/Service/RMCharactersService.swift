//
//  CharactersService.swift
//  RickAndMortyCatalog
//
//  Created by Andre Sanches Bocato on 09/04/19.
//  Copyright © 2019 Andre Sanches Bocato. All rights reserved.
//

import Foundation

class RMCharactersService: RMCharactersServiceProtocol {
    
    // MARK: - Protocol Stubs
    
    func getAllCharacters(completionHandler: @escaping (Result<[RMCharacter], ServiceError>) -> Void) {
        
        // @TODO:
    }
    
    func getCharacter(withID: Int?,
                      completionHandler: @escaping (Result<RMCharacter, ServiceError>) -> Void) {
        
        // @TODO:
    }
    
    func getAllCharactersInRange(_ range: (start: Int, end: Int),
                                 completionHandler: @escaping (Result<RMCharacter, ServiceError>) -> Void) {
        
        // @TODO:
    }
    
    func filterCharacters(_ filters: [RMCharactersFilter],
                          completionHandler: @escaping (Result<[RMCharacter], ServiceError>) -> Void) {
        
        // @TODO:
    }
    
}

// MARK: - Protocols

protocol RMCharactersServiceProtocol {
    func getAllCharacters(completionHandler: @escaping (Result<[RMCharacter], ServiceError>) -> Void)
    func getCharacter(withID: Int?, completionHandler: @escaping (Result<RMCharacter, ServiceError>) -> Void)
    func getAllCharactersInRange(_ range: (start: Int, end: Int), completionHandler: @escaping (Result<RMCharacter, ServiceError>) -> Void)
    func filterCharacters(_ filters: [RMCharactersFilter], completionHandler: @escaping (Result<[RMCharacter], ServiceError>) -> Void)
}

// MARK: - Mocked Service

class RMCharactersServiceMock: RMCharactersServiceProtocol { // @TODO: Mock with jsons
    
    // MARK: - Protocol Stubs
    
    func getAllCharacters(completionHandler: @escaping (Result<[RMCharacter], ServiceError>) -> Void) {
        
        let mockedCharacters = [
            RMCharacter(id: 1, name: "Rick", status: "Alive", species: "Human", type: "Rick type", gender: "Male", origin: RMCharacterOrigin(name: "Earth", url: nil), location: RMCharacterLocation(name: "Unknown", url: nil), image: "https://rickandmortyapi.com/api/character/avatar/58.jpeg", episode: nil, url: nil, created: nil),
            RMCharacter(id: 23, name: "Morty", status: "Dead", species: "Fish", type: "Morty type", gender: "Male", origin: RMCharacterOrigin(name: "Sun", url: nil), location: RMCharacterLocation(name: "Earth", url: nil), image: "https://rickandmortyapi.com/api/character/avatar/466.jpeg", episode: nil, url: nil, created: nil),
            RMCharacter(id: 456, name: "Summer", status: "Unknown", species: "Kronenberg", type: "Summer type", gender: "Female", origin: RMCharacterOrigin(name: "Moon", url: nil), location: RMCharacterLocation(name: "Venus", url: nil), image: "https://rickandmortyapi.com/api/character/avatar/130.jpeg", episode: nil, url: nil, created: nil)
        ]
        
        completionHandler(.success(mockedCharacters))
    }
    
    func getCharacter(withID: Int?,
                      completionHandler: @escaping (Result<RMCharacter, ServiceError>) -> Void) {
        
        let mockedCharacter = RMCharacter(id: 1, name: "Rick", status: "Alive", species: "Human", type: "Rick type", gender: "Male", origin: RMCharacterOrigin(name: "Earth", url: nil), location: RMCharacterLocation(name: "Unknown", url: nil), image: "https://rickandmortyapi.com/api/character/avatar/58.jpeg", episode: nil, url: nil, created: nil)
        
        completionHandler(.success(mockedCharacter))
    }
    
    func getAllCharactersInRange(_ range: (start: Int, end: Int),
                                 completionHandler: @escaping (Result<RMCharacter, ServiceError>) -> Void) {
        
        //
    }
    
    func filterCharacters(_ filters: [RMCharactersFilter],
                          completionHandler: @escaping (Result<[RMCharacter], ServiceError>) -> Void) {
        
        //
    }

}

