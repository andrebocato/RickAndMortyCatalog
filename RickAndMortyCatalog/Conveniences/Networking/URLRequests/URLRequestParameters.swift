//
//  URLRequestParameters.swift
//  RickAndMortyCatalog
//
//  Created by Andre Sanches Bocato on 23/04/19.
//  Copyright © 2019 Andre Sanches Bocato. All rights reserved.
//

import Foundation

/// Defines the parameters to pass along with the request
///
/// - body: parameters to be embeded on the body of the request
/// - url: path parameters to be set o the URL
public enum URLRequestParameters {
    case body(_: [String: Any]?)
    case url(_: [String: String]?)
}
