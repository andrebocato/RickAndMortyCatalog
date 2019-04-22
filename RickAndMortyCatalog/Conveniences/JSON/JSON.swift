//
//  JSON.swift
//  RickAndMortyCatalog
//
//  Created by Andre Sanches Bocato on 09/04/19.
//  Copyright © 2019 Andre Sanches Bocato. All rights reserved.
//

import Foundation

class JSON {
    
    /// Converts a dictionary into binary data.
    ///
    /// - Parameter dictionary: Dictionary to be serialized.
    /// - Returns: Binary data converted from the dictionary.
    class func serialize(dictionary: [String: Any]) -> Data? {
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: dictionary, options: .prettyPrinted)
            return jsonData
        } catch {
            return nil
        }
    }
    
    /// Converts binary data into a dictionary.
    ///
    /// - Parameter data: Binary data to be deserialized.
    /// - Returns: Dictionary converted from the data.
    class func deserialize(data: Data) -> [String: Any]? {
        do {
            let jsonDictionary = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
            return jsonDictionary as? [String: Any]
        } catch {
            return nil
        }
    }
    
}
