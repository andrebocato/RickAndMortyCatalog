//
//  RMCharactersAPIProtocol.swift
//  RickAndMortyCatalog
//
//  Created by Andre Sanches Bocato on 09/04/19.
//  Copyright © 2019 Andre Sanches Bocato. All rights reserved.
//

import Foundation

protocol RMCharactersAPIProtocol {
    func getAllCharacters(completionHandler: @escaping (Result<[RMCharacter], ServiceError>) -> Void)
    
    func getCharacter(withID: Int?,
                      completionHandler: @escaping (Result<RMCharacter, ServiceError>) -> Void)
    
    func getAllCharactersInRange(_ range: (start: Int, end: Int),
                                 completionHandler: @escaping (Result<RMCharacter, ServiceError>) -> Void)
    
    func filterCharacters(_ filters: [RMCharactersFilter],
                          completionHandler: @escaping (Result<[RMCharacter], ServiceError>) -> Void)
}
