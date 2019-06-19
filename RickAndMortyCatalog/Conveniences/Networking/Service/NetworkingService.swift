//
//  NetworkingService.swift
//  RickAndMortyCatalog
//
//  Created by Andre Sanches Bocato on 23/04/19.
//  Copyright © 2019 Andre Sanches Bocato. All rights reserved.
//

import Foundation

// MARK: - Protocol

/// Defines an API service.
public protocol NetworkingService {
    /// The dispatcher to take care of the network requests.
    var dispatcher: URLRequestDispatcherProtocol { get }
    /// Intializer to inject the dispatcher.
    ///
    /// - Parameter dispatcher: The dispatcher to take care of the network requests.
    init(dispatcher: URLRequestDispatcherProtocol)
}

// MARK: - Networking Service Serializer

extension NetworkingService {
    
    /// Helper function to serialize results when needed.
    ///
    /// - Parameters:
    ///   - result: The result from the dispatcher.
    ///   - responseType: The response type (Codable).
    ///   - completion: The serialization completion handler.
    public func serializeDispatcherResult<ResponseType: Codable>(_ result: Result<Data?, URLRequestError>,
                                                                 responseType: ResponseType.Type,
                                                                 completion: @escaping (Result<ResponseType, ServiceError>) -> Void) {
        
        switch result {
        case .success(let data):
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            
            do {
                let serializedResponse = try JSONDecoder().decode(responseType.self, from: data)
                completion(.success(serializedResponse))
            } catch {
                debugPrint(error)
                completion(.failure(.serializationError(error)))
            }
            
        case .failure(let error):
            completion(.failure(.api(error)))
        }
    }
    
}
