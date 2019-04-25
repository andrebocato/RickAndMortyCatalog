//
//  URLRequestAdapter.swift
//  RickAndMortyCatalog
//
//  Created by Andre Sanches Bocato on 23/04/19.
//  Copyright © 2019 Andre Sanches Bocato. All rights reserved.
//

import Foundation

public protocol URLRequestAdapter {
    /// Inspects and adapts the specified `URLRequest` in some manner if necessary and returns the result.
    ///
    /// - Parameter urlRequest: The URL request to adapt.
    /// - Returns: The adapted `URLRequest`.
    /// - Throws: An `Error` if the adaptation encounters an error.
    func adapt(_ urlRequest: URLRequest) throws -> URLRequest
}
