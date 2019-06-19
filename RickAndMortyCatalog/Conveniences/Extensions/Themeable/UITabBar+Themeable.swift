//
//  UITabBar+ApplyTheme.swift
//  RickAndMortyCatalog
//
//  Created by Andre Sanches Bocato on 27/05/19.
//  Copyright © 2019 Andre Sanches Bocato. All rights reserved.
//

import UIKit

extension UITabBar: Themeable {
    
    func apply(_ theme: ThemeType) {
        unselectedItemTintColor = theme.unselectedButtonColor
        tintColor = theme.selectedButtonColor
        barTintColor = theme.tabBarColor
    }
    
}
