//
//  UIFont+CustomFonts.swift
//  RickAndMortyCatalog
//
//  Created by Andre Sanches Bocato on 14/05/19.
//  Copyright © 2019 Andre Sanches Bocato. All rights reserved.
//

import UIKit

extension UIFont {
    
    /// "Cartoon Toy" font with a defined size.
    ///
    /// - Parameter ofSize: Font size.
    /// - Returns: The font.
    class func cartoonToy(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: "Cartoon Toy", size: size) ?? .systemFont(ofSize: size)
    }
    
    /// "Shlop" font with a defined size.
    ///
    /// - Parameter ofSize: Font size.
    /// - Returns: The font.
    class func shlop(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: "shlop rg", size: size) ?? .systemFont(ofSize: size)
    }
    
}
