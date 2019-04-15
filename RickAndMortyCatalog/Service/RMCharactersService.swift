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
    
    func getCharacter(withID: Int?,
                      completionHandler: @escaping (Result<RMCharacter, ServiceError>) -> Void)
    
    func getAllCharactersInRange(_ range: (start: Int, end: Int),
                                 completionHandler: @escaping (Result<RMCharacter, ServiceError>) -> Void)
    
    func filterCharacters(_ filters: [RMCharactersFilter],
                          completionHandler: @escaping (Result<[RMCharacter], ServiceError>) -> Void)
}

// MARK: - Mocked Service

class RMCharactersServiceMock: RMCharactersServiceProtocol { // @TODO: Mock with jsons
    
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

