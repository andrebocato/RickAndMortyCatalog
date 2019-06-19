//
//  SimpleURLRequest.swift
//  RickAndMortyCatalog
//
//  Created by Andre Sanches Bocato on 23/04/19.
//  Copyright © 2019 Andre Sanches Bocato. All rights reserved.
//

import Foundation

struct SimpleURLRequest: URLRequestProtocol {
    
    var baseURL: URL
    var path: String?
    var method: HTTPMethod
    var parameters: URLRequestParameters?
    var headers: [String: Any]?
    
    init(baseURL: URL,
         method: HTTPMethod = .get) {
        self.baseURL = baseURL
        self.method = method
    }
    
}
