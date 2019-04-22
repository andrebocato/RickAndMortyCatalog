//
//  UICollectionViewCell+Identifier.swift
//  RickAndMortyCatalog
//
//  Created by Andre Sanches Bocato on 16/04/19.
//  Copyright © 2019 Andre Sanches Bocato. All rights reserved.
//

import UIKit

extension UICollectionViewCell {
    
    static var identifier: String {
        return String(describing: self)
    }
    
}
