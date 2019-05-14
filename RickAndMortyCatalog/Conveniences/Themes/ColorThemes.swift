//
//  ColorThemes.swift
//  RickAndMortyCatalog
//
//  Created by Andre Sanches Bocato on 14/05/19.
//  Copyright © 2019 Andre Sanches Bocato. All rights reserved.
//

import UIKit

struct DarkTheme {
    static var cellBackgroundColor: UIColor {
        return UIColor(red: 0.19, green: 0.20, blue: 0.20, alpha: 1.0)
    }
    static var viewBackgroundColor: UIColor {
        return UIColor(red: 0.23, green: 0.25, blue: 0.25, alpha: 1.0)
    }
    static var textColor: UIColor {
        return UIColor(red: 0.67, green: 0.67, blue: 0.68, alpha: 1.0)
    }
    static var selectedCellBackgroundColor: UIColor {
        return UIColor(red: 0.24, green: 0.28, blue: 0.29, alpha: 1.0)
    }
    static var tabBarColor: UIColor {
        return UIColor(red: 0.14, green: 0.15, blue: 0.15, alpha: 1.0)
    }
    static var buttonColor: UIColor {
        return UIColor(red: 0.97, green: 0.52, blue: 0.18, alpha: 1.0)
    }
}

struct DefaultTheme {
    static var cellBackgroundColor: UIColor {
        return .white
    }
    static var viewBackgroundColor: UIColor {
        return UIColor(red: 0.96, green: 0.97, blue: 0.97, alpha: 1.0)
    }
    static var textColor: UIColor {
        return UIColor(red: 0.12, green: 0.12, blue: 0.12, alpha: 1.0)
    }
    static var selectedCellBackgroundColor: UIColor {
        return UIColor(red: 0.38, green: 0.40, blue: 0.40, alpha: 1.0)
    }
    static var tabBarColor: UIColor {
        return UIColor(red: 0.98, green: 0.98, blue: 0.98, alpha: 1.0)
    }
    static var buttonColor: UIColor {
        return UIColor(red: 0.41, green: 0.71, blue: 0.71, alpha: 1.0)
    }
}

