//
//  UINavigationBar+Themeable.swift
//  RickAndMortyCatalog
//
//  Created by Andre Sanches Bocato on 27/05/19.
//  Copyright © 2019 Andre Sanches Bocato. All rights reserved.
//

import UIKit

extension UINavigationBar: Themeable {
   
    func apply(_ theme: ThemeType) {
        barTintColor = theme.tabBarColor
        titleTextAttributes = [.foregroundColor: theme.titleTextColor]
        tintColor = theme.titleTextColor
    }
    
}
