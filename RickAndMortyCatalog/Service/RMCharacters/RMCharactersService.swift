//
//  CharactersService.swift
//  RickAndMortyCatalog
//
//  Created by Andre Sanches Bocato on 09/04/19.
//  Copyright © 2019 Andre Sanches Bocato. All rights reserved.
//

import Foundation

// MARK: - Protocols

protocol RMCharactersServiceProtocol: APIService {
    @discardableResult func getAllCharacters(completionHandler: @escaping (Result<[RMCharacter], ServiceError>) -> Void) -> URLRequestToken?
    @discardableResult func getCharacter(withID id: Int, completionHandler: @escaping (Result<RMCharacter, ServiceError>) -> Void) -> URLRequestToken?
    @discardableResult func getAllCharactersInRange(_ range: (start: Int, end: Int), completionHandler: @escaping (Result<[RMCharacter], ServiceError>) -> Void) -> URLRequestToken?
    @discardableResult func filterCharacters(_ filters: [RMCharactersFilter], completionHandler: @escaping (Result<[RMCharacter], ServiceError>) -> Void) -> URLRequestToken?
    @discardableResult func getImageDataFromURL(_ url: String, completionHandler: @escaping (Result<Data, ServiceError>) -> Void) -> URLRequestToken?
}

class RMCharactersService: RMCharactersServiceProtocol {
    
    // MARK: - Properties
    
    internal let dispatcher: URLRequestDispatcherProtocol
    
    // MARK: Initiliazation
    
    required init(dispatcher: URLRequestDispatcherProtocol) {
        self.dispatcher = dispatcher
    }
    
    // MARK: - Protocol Stubs
    
    @discardableResult
    func getAllCharacters(completionHandler: @escaping (Result<[RMCharacter], ServiceError>) -> Void) -> URLRequestToken? {
        
        let request: RMCharactersRequest = .allCharacters
        return dispatcher.execute(request: request, completion: { (result) in
            self.serializeDispatcherResult(result, responseType: [RMCharacter].self, completion: completionHandler)
        })
    }
    
    @discardableResult
    func getCharacter(withID id: Int,
                      completionHandler: @escaping (Result<RMCharacter, ServiceError>) -> Void)  -> URLRequestToken? {
        
        let request: RMCharactersRequest = .characterWithID(id)
        return dispatcher.execute(request: request, completion: { (result) in
            self.serializeDispatcherResult(result, responseType: RMCharacter.self, completion: completionHandler)
        })
    }
    
    @discardableResult
    func getAllCharactersInRange(_ range: (start: Int, end: Int),
                                 completionHandler: @escaping (Result<[RMCharacter], ServiceError>) -> Void)  -> URLRequestToken? {
        
        let request: RMCharactersRequest = .characterInRange(range.start, range.end)
        return dispatcher.execute(request: request, completion: { (result) in
            self.serializeDispatcherResult(result, responseType: [RMCharacter].self, completion: completionHandler)
        })
    }
    
    @discardableResult
    func filterCharacters(_ filters: [RMCharactersFilter],
                          completionHandler: @escaping (Result<[RMCharacter], ServiceError>) -> Void)  -> URLRequestToken? {
        
        // @TODO:
        
        return nil
    }
    
    @discardableResult
    func getImageDataFromURL(_ url: String, completionHandler: @escaping (Result<Data, ServiceError>) -> Void) -> URLRequestToken? {
        return nil // TODO: Define
    }
    
}


