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
        let mockedCharactersJSON: [String: Any] = [
            "info": [
                "count": 394,
                "pages": 20,
                "next": "https://rickandmortyapi.com/api/character/?page=2",
                "prev": ""
            ],
            "results": [
                [
                    "id": 1,
                    "name": "Rick Sanchez",
                    "status": "Alive",
                    "species": "Human",
                    "type": "",
                    "gender": "Male",
                    "origin": [
                        "name": "Earth",
                        "url": "https://rickandmortyapi.com/api/location/1"
                    ],
                    "location": [
                        "name": "Earth",
                        "url": "https://rickandmortyapi.com/api/location/20"
                    ],
                    "image": "https://rickandmortyapi.com/api/character/avatar/1.jpeg",
                    "episode": [
                        "https://rickandmortyapi.com/api/episode/1",
                        "https://rickandmortyapi.com/api/episode/2",
                        "https://rickandmortyapi.com/api/episode/3"
                    ],
                    "url": "https://rickandmortyapi.com/api/character/1",
                    "created": "2017-11-04T18:48:46.250Z"
                ],
                [
                    "id": 2,
                    "name": "Rick Sanchez2",
                    "status": "Alive2",
                    "species": "Human2",
                    "type": "",
                    "gender": "Male2",
                    "origin": [
                        "name": "Earth2",
                        "url": "https://rickandmortyapi.com/api/location/1"
                    ],
                    "location": [
                        "name": "Earth2",
                        "url": "https://rickandmortyapi.com/api/location/20"
                    ],
                    "image": "https://rickandmortyapi.com/api/character/avatar/1.jpeg",
                    "episode": [
                        "https://rickandmortyapi.com/api/episode/1",
                        "https://rickandmortyapi.com/api/episode/2",
                        "https://rickandmortyapi.com/api/episode/3"
                    ],
                    "url": "https://rickandmortyapi.com/api/character/1",
                    "created": "2017-11-04T18:48:46.250Z"
                ]
            ]
        ]
        
        completionHandler(.success(<#Success#>))
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

