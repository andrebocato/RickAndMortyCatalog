//
//  SimpleURLRequest.swift
//  RickAndMortyCatalog
//
//  Created by Eduardo Sanches Bocato on 23/04/19.
//  Copyright © 2019 Andre Sanches Bocato. All rights reserved.
//

import Foundation

struct SimpleURLRequest: URLRequestProtocol {
    
    var baseURL: URL
    var path: String? = nil
    var method: HTTPMethod
    var parameters: URLRequestParameters? = nil
    var headers: [String : Any]? = nil
    
    init(baseURL: URL, method: HTTPMethod = .get) {
        self.baseURL = baseURL
        self.method = method
    }
    
}
