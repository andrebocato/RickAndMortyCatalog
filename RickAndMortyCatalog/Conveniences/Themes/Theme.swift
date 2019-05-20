//
//  Theme.swift
//  RickAndMortyCatalog
//
//  Created by Andre Sanches Bocato on 16/05/19.
//  Copyright © 2019 Andre Sanches Bocato. All rights reserved.
//

import UIKit

// MARK: - Theme Type

protocol ThemeType {
    var cellBackgroundColor: UIColor { get }
    var viewBackgroundColor: UIColor { get }
    var textColor: UIColor { get }
    var selectedCellBackgroundColor: UIColor { get }
    var tabBarColor: UIColor { get }
    var unselectedButtonColor: UIColor { get }
    var selectedButtonColor: UIColor { get }
}

// MARK: - Themes

enum Theme: String, ThemeType {
    
    case dark = "dark"
    case `default` = "defaultt"
    
    var cellBackgroundColor: UIColor {
        switch self {
        case .dark:
            return UIColor(red: 0.19, green: 0.20, blue: 0.20, alpha: 1.0)
        case .`default`:
            return .white
        }
    }
    
    var viewBackgroundColor: UIColor {
        switch self {
        case .dark:
            return UIColor(red: 0.23, green: 0.25, blue: 0.25, alpha: 1.0)
        case .`default`:
            return UIColor(red: 0.96, green: 0.97, blue: 0.97, alpha: 1.0)
        }
    }
    
    var textColor: UIColor {
        switch self {
        case .dark:
            return UIColor(red: 0.67, green: 0.67, blue: 0.68, alpha: 1.0)
        case .`default`:
            return UIColor(red: 0.12, green: 0.12, blue: 0.12, alpha: 1.0)
        }
    }
    
    var selectedCellBackgroundColor: UIColor {
        switch self {
        case .dark:
            return UIColor(red: 0.24, green: 0.28, blue: 0.29, alpha: 1.0)
        case .`default`:
            return UIColor(red: 0.38, green: 0.40, blue: 0.40, alpha: 1.0)
        }
    }
    
    var tabBarColor: UIColor {
        switch self {
        case .dark:
            return UIColor(red: 0.14, green: 0.15, blue: 0.15, alpha: 1.0)
        case .`default`:
            return UIColor(red: 0.98, green: 0.98, blue: 0.98, alpha: 1.0)
        }
    }
    
    var unselectedButtonColor: UIColor {
        switch self {
        case .dark:
            return UIColor(red: 0.97, green: 0.52, blue: 0.18, alpha: 1.0)
        case .`default`:
            return UIColor(red: 0.41, green: 0.71, blue: 0.71, alpha: 1.0)
        }
    }
    
    var selectedButtonColor: UIColor {
        switch self {
        case .dark:
            return UIColor(red: 0.53, green: 0.27, blue: 0.06, alpha: 1.0)
        case .light:
            return UIColor(red: 0.20, green: 0.37, blue: 0.39, alpha: 1.0)
        }
    }
    
}
