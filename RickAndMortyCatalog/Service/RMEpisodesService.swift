//
//  RMEpisodesService.swift
//  RickAndMortyCatalog
//
//  Created by Andre Sanches Bocato on 15/04/19.
//  Copyright © 2019 Andre Sanches Bocato. All rights reserved.
//

import Foundation

class RMEpisodesService: RMEpisodesServiceProtocol {
    
    // MARK: - Protocol Stubs
    
    func getAllEpisodes(completionHandler: @escaping (Result<[RMEpisode], ServiceError>) -> Void) {
        
        // @TODO:
    }
    
    func getEpisode(withID: Int?,
                     completionHandler: @escaping (Result<RMEpisode, ServiceError>) -> Void) {
        
        // @TODO:
    }
    
    func getAllEpisodesInRange(_ range: (start: Int, end: Int),
                                completionHandler: @escaping (Result<RMEpisode, ServiceError>) -> Void) {
        
        // @TODO:
    }
    
    func filterEpisodes(_ filters: [RMEpisodesFilter],
                         completionHandler: @escaping (Result<[RMEpisode], ServiceError>) -> Void) {
        
        // @TODO:
    }
    
}

// MARK: - Protocols

protocol RMEpisodesServiceProtocol {
    func getAllEpisodes(completionHandler: @escaping (Result<[RMEpisode], ServiceError>) -> Void)
    
    func getEpisode(withID: Int?,
                     completionHandler: @escaping (Result<RMEpisode, ServiceError>) -> Void)
    
    func getAllEpisodesInRange(_ range: (start: Int, end: Int),
                                completionHandler: @escaping (Result<RMEpisode, ServiceError>) -> Void)
    
    func filterEpisodes(_ filters: [RMEpisodesFilter],
                         completionHandler: @escaping (Result<[RMEpisode], ServiceError>) -> Void)
}
