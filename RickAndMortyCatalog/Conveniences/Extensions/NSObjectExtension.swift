//
//  NSObjectExtension.swift
//  RickAndMortyCatalog
//
//  Created by Andre Sanches Bocato on 23/04/19.
//  Copyright © 2019 Andre Sanches Bocato. All rights reserved.
//

import Foundation

extension NSObject {
    
    /// String describing the class name.
    static var className: String {
        return String(describing: self)
    }
    
}
