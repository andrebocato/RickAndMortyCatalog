//
//  UIAlertController+Themeable.swift
//  RickAndMortyCatalog
//
//  Created by Andre Sanches Bocato on 29/05/19.
//  Copyright © 2019 Andre Sanches Bocato. All rights reserved.
//

// @TODO: finish implementation

import UIKit

extension UIAlertController: Themeable {
        
    func apply(_ theme: ThemeType) {
        view.backgroundColor = theme.viewBackgroundColor
    }
    
}
