//
//  RMCharactersRequest.swift
//  RickAndMortyCatalog
//
//  Created by Andre Sanches Bocato on 23/04/19.
//  Copyright © 2019 Andre Sanches Bocato. All rights reserved.
//

import Foundation

enum RMCharactersRequest: URLRequestProtocol {
    
    case allCharactersOnPage(Int)
    case characterWithID(Int)
    case characterInRange(Int,Int)
    
    var baseURL: URL {
        return URL(string: "https://rickandmortyapi.com/api/")!
    }
    
    var path: String? {
        return "character"
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var parameters: URLRequestParameters? {
        switch self {
        case .allCharactersOnPage(let page):
            return .url(["page": "\(page)"])
            
        case .characterWithID(let id):
            return .url(["": "\(id)"])
            
        case .characterInRange(let start, let end):
            return .url(["": "\(start),\(end)"])
        }
    }
    
    var headers: [String : Any]? {
        return ["content-type": "application/json"]
    }
    
}
