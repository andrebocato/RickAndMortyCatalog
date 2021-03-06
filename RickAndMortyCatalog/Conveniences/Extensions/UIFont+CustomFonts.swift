//
//  UIFont+CustomFonts.swift
//  RickAndMortyCatalog
//
//  Created by Andre Sanches Bocato on 14/05/19.
//  Copyright © 2019 Andre Sanches Bocato. All rights reserved.
//

import UIKit

extension UIFont {
        
    /// "La Cartoonerie" font with a defined size.
    ///
    /// - Parameter ofSize: Font size.
    /// - Returns: The font.
    class func laCartoonerie(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: "laCartoonerie", size: size) ?? .systemFont(ofSize: size)
    }
    
}
