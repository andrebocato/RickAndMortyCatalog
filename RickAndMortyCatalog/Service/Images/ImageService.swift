//
//  ImageService.swift
//  RickAndMortyCatalog
//
//  Created by Eduardo Sanches Bocato on 24/04/19.
//  Copyright © 2019 Andre Sanches Bocato. All rights reserved.
//

import Foundation


/// Defines an image service, to fetch images data from cache or the network
protocol ImageServiceProtocol {
    
    /// Initializes an ImageService with it's dependencies
    ///
    /// - Parameters:
    ///   - networkDispatcher: to fetch images from the Network
    ///   - cacheService: to load the cached data
    init(networkDispatcher: URLRequestDispatcherProtocol, cacheService: CacheServiceProtocol)
    
    /// Gets and image from the URL, it can be in the cache or fetched from the network
    ///
    /// - Parameters:
    ///   - url: the image URL
    ///   - completionHandler: the completion handler for the fetch operation
    /// - Returns: an image, if present or a networking error
    @discardableResult func getImageDataFromURL(_ url: String, completionHandler: @escaping (Result<Data, ServiceError>) -> Void) -> URLRequestToken?
}

class ImageService: ImageServiceProtocol {
    
    // MARK: - Properties

    private let networkDispatcher: URLRequestDispatcherProtocol
    private let cacheService: CacheServiceProtocol
    
    
    required init(networkDispatcher: URLRequestDispatcherProtocol, cacheService: CacheServiceProtocol) {
        self.networkDispatcher = networkDispatcher
        self.cacheService = cacheService
    }
    
    deinit {
        cacheService.clear {
            switch $0 {
            case .failure(let error): debugPrint(error)
            case .success: debugPrint("Successfuly cleared the cache.")
            }
        }
    }
    
    @discardableResult
    func getImageDataFromURL(_ url: String, completionHandler: @escaping (Result<Data, ServiceError>) -> Void) -> URLRequestToken? {
        
        var requestToken: URLRequestToken?
        
        cacheService.loadData(from: url) { (cacheResult) in
            
            do {
                
                let dataFromCache = try cacheResult.get()
                completionHandler(.success(dataFromCache))
                
            } catch {
                
                guard let imageURL = URL(string: url) else {
                    completionHandler(.failure(.unexpected))
                    return
                }
                
                let request = SimpleURLRequest(baseURL: imageURL)
                
                requestToken = networkDispatcher.execute(request: request) { [weak self] (result) in
                    
                    do {
                        
                        guard let data = try result.get() else {
                            completionHandler(.failure(.noData))
                            return
                        }
                        
                        self?.cacheService.save(data: data, key: url, completion: nil)
                        
                        completionHandler(.success(data))
                        
                    } catch {
                        completionHandler(.failure(.api(.raw(error))))
                    }
                    
                }
            }
            
        }
        
        return requestToken
        
    }
    
}


