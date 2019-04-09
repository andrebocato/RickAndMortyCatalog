//
//  LocationsService.swift
//  RickAndMortyCatalog
//
//  Created by Andre Sanches Bocato on 09/04/19.
//  Copyright © 2019 Andre Sanches Bocato. All rights reserved.
//

import Foundation

class RMLocationsService: RMLocationsAPIProtocol {
    
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
    
    func filterLocations(_ filters: [RMCharactersFilter],
                         completionHandler: @escaping (Result<[RMLocation], ServiceError>) -> Void) {
        
        // @TODO:
    }
    
}
