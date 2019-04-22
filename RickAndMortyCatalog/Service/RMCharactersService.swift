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
    
    func getCharacter(withID id: Int,
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
    func getCharacter(withID id: Int, completionHandler: @escaping (Result<RMCharacter, ServiceError>) -> Void)
    func getAllCharactersInRange(_ range: (start: Int, end: Int), completionHandler: @escaping (Result<RMCharacter, ServiceError>) -> Void)
    func filterCharacters(_ filters: [RMCharactersFilter], completionHandler: @escaping (Result<[RMCharacter], ServiceError>) -> Void)
}

// MARK: - Mocked Service

class RMCharactersServiceMock: RMCharactersServiceProtocol {
    
    // MARK: - Protocol Stubs
    
    func getAllCharacters(completionHandler: @escaping (Result<[RMCharacter], ServiceError>) -> Void) {
        
        // Example using JSON strings on the code.
        guard let mockedCharactersData = """
            {
               "info":{
                  "count":394,
                  "pages":20,
                  "next":"https://rickandmortyapi.com/api/character/?page=2",
                  "prev":""
            },
               "results": [
                  {
                     "id":1,
                     "name":"Rick Sanchez",
                     "status":"Alive",
                     "species":"Human",
                     "type":"",
                     "gender":"Male",
                     "origin":{
                        "name":"Earth (C-137)",
                        "url":"https://rickandmortyapi.com/api/location/1"
                     },
                     "location":{
                        "name":"Earth (Replacement Dimension)",
                        "url":"https://rickandmortyapi.com/api/location/20"
                     },
                     "image":"https://rickandmortyapi.com/api/character/avatar/1.jpeg",
                     "episode":[
                        "https://rickandmortyapi.com/api/episode/1",
                        "https://rickandmortyapi.com/api/episode/2"
                     ],
                     "url":"https://rickandmortyapi.com/api/character/1",
                     "created":"2017-11-04T18:48:46.250Z"
                  },
                  {
                     "id":183,
                     "name":"Johnny Depp",
                     "status":"Alive",
                     "species":"Human",
                     "type":"",
                     "gender":"Male",
                     "origin":{
                        "name":"Earth (C-500A)",
                        "url":"https://rickandmortyapi.com/api/location/23"
                     },
                     "location":{
                        "name":"Earth (C-500A)",
                        "url":"https://rickandmortyapi.com/api/location/23"
                     },
                     "image":"https://rickandmortyapi.com/api/character/avatar/183.jpeg",
                     "episode":[
                        "https://rickandmortyapi.com/api/episode/8"
                     ],
                     "url":"https://rickandmortyapi.com/api/character/183",
                     "created":"2017-12-29T18:51:29.693Z"
                  }
               ]
            }
        """.data(using: .utf8) else { return }
        
        do {
           let mockedCharacters  = try JSONDecoder().decode(RMCharacterResponse.self, from: mockedCharactersData)
            completionHandler(.success(mockedCharacters.results))
        } catch {
            debugPrint(error.localizedDescription)
            fatalError("Could not parse JSON, check if its validity.")
        }
        
    }
    
    func getCharacter(withID: Int,
                      completionHandler: @escaping (Result<RMCharacter, ServiceError>) -> Void) {
        
        // Example getting the JSON data from a file on the project
        let bundle = Bundle(for: RMCharactersServiceMock.self)
        guard let path = bundle.path(forResource: "GetCharacterMock", ofType: "json"),
            let jsonData = try? Data(contentsOf: URL(fileURLWithPath: path)) else {
                fatalError("Resource not found!")
        }
        
        guard let mockedCharacter = try? JSONDecoder().decode(RMCharacter.self, from: jsonData) else {
            fatalError("Could not parse JSON, check if its validity.")
        }
        
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

