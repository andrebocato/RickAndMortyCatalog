//
//  LocationsService.swift
//  RickAndMortyCatalog
//
//  Created by Andre Sanches Bocato on 09/04/19.
//  Copyright © 2019 Andre Sanches Bocato. All rights reserved.
//

import Foundation

class RMLocationsService: RMLocationsServiceProtocol {
    
    // MARK: - Protocol Stubs
    
    func getAllLocations(completionHandler: @escaping (Result<[RMLocation], ServiceError>) -> Void) {
        
        // @TODO:
    }
    
    func getLocation(withID: Int?,
                     completionHandler: @escaping (Result<RMLocation, ServiceError>) -> Void) {
        
        // @TODO:
    }
    
    func getAllLocationsInRange(_ range: (start: Int, end: Int),
                                completionHandler: @escaping (Result<RMLocation, ServiceError>) -> Void) {
        
        // @TODO:
    }
    
    func filterLocations(_ filters: [RMLocationsFilter],
                         completionHandler: @escaping (Result<[RMLocation], ServiceError>) -> Void) {
        
        // @TODO:
    }
    
}

// MARK: - Protocols

protocol RMLocationsServiceProtocol {
    func getAllLocations(completionHandler: @escaping (Result<[RMLocation], ServiceError>) -> Void)
    func getLocation(withID: Int?, completionHandler: @escaping (Result<RMLocation, ServiceError>) -> Void)
    func getAllLocationsInRange(_ range: (start: Int, end: Int), completionHandler: @escaping (Result<RMLocation, ServiceError>) -> Void)
    func filterLocations(_ filters: [RMLocationsFilter], completionHandler: @escaping (Result<[RMLocation], ServiceError>) -> Void)
}
