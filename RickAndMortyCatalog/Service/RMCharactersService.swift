//
//  CharactersService.swift
//  RickAndMortyCatalog
//
//  Created by Andre Sanches Bocato on 09/04/19.
//  Copyright © 2019 Andre Sanches Bocato. All rights reserved.
//

import Foundation

class RMCharactersService: RMCharactersAPIProtocol {
    
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

class RMCharactersServiceMock: RMCharactersAPIProtocol { // @TODO: Mock with jsons
    
    // MARK: - Protocol Stubs
    
    func getAllCharacters(completionHandler: @escaping (Result<[RMCharacter], ServiceError>) -> Void) {
        let mockedCharacters = [
            RMCharacter(id: 0, name: "Character 1"),
            RMCharacter(id: 0, name: "Character 1"),
            RMCharacter(id: 0, name: "Character 1"),
            RMCharacter(id: 0, name: "Character 1")
        ]
        completion(.success(mockedCharacters))
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
