//
//  FavoritesDatabaseObservationToken.swift
//  RickAndMortyCatalog
//
//  Created by Eduardo Sanches Bocato on 28/04/19.
//  Copyright © 2019 Andre Sanches Bocato. All rights reserved.
//

import Foundation

/// Define an observation token abstraction
protocol FavoritesDatabaseObservationToken {
    
    /// Invalidates the observation token
    func invalidate()
    
}
