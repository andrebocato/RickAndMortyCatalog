//
//  RMCharactersRequest.swift
//  RickAndMortyCatalog
//
//  Created by Andre Sanches Bocato on 23/04/19.
//  Copyright © 2019 Andre Sanches Bocato. All rights reserved.
//

import Foundation

enum RMCharactersRequest: URLRequestProtocol {
    
    case allCharacters
    case characterWithID(Int)
    case characterInRange(Int,Int)
    case charactersWithFilters([RMCharactersFilter])
    
    var baseURL: URL {
        return URL(string: "https://rickandmortyapi.com/api/")!
    }
    
    var path: String {
        return "character"
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var parameters: URLRequestParameters? {
        switch self {
        case .allCharacters:
            return nil
        case .characterWithID(let id):
            return .url(["": "\(id)"])
        case .characterInRange(let start, let end):
            return .url(["": "\(start),\(end)"])
        case .charactersWithFilters(let filters): // TODO: Check this... The modeling is not ok
            return nil
        }
    }
    
    var headers: [String : Any]? {
        return ["content-type": "application/json"]
    }
    
}
