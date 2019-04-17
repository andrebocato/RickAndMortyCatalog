//
//  RMLocation+Extension.swift
//  RickAndMortyCatalog
//
//  Created by Andre Sanches Bocato on 17/04/19.
//  Copyright © 2019 Andre Sanches Bocato. All rights reserved.
//

import Foundation

extension RMLocation {
    
    // MARK: - Functions
    
    /// Used to get the RMCharacter IDs refering to a RMLocation.
    ///
    /// - Parameter location: RMLocation containing the list of residents (as URLs).
    /// - Returns: Array of integers refering to RMCharacters IDs.
    func residentIDs() -> [Int] {
        var residentsIDs = [Int]()
        guard let residents = self.residents else { return [] }
        for residentURL in residents {
            let id = Int(residentURL.replacingOccurrences(of: "https://rickandmortyapi.com/api/character/", with: "")) ?? 0
            residentsIDs.append(id)
        }
        
        return residentsIDs
    }
    
}
