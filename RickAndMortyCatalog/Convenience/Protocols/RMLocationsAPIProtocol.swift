//
//  RMLocationsAPIProtocol.swift
//  RickAndMortyCatalog
//
//  Created by Andre Sanches Bocato on 09/04/19.
//  Copyright © 2019 Andre Sanches Bocato. All rights reserved.
//

import Foundation

protocol RMLocationsAPIProtocol {
    func getAllLocations(completionHandler: @escaping (Result<[RMLocation], ServiceError>) -> Void)
    
    func getLocation(withID: Int?,
                     completionHandler: @escaping (Result<RMLocation, ServiceError>) -> Void)
    
    func getAllLocationsInRange(_ range: (start: Int, end: Int),
                                completionHandler: @escaping (Result<RMLocation, ServiceError>) -> Void)
    
    func filterLocations(_ filters: [RMCharactersFilter],
                         completionHandler: @escaping (Result<[RMLocation], ServiceError>) -> Void)
}
