//
//  DestructiveCell.swift
//  RickAndMortyCatalog
//
//  Created by Andre Sanches Bocato on 13/05/19.
//  Copyright © 2019 Andre Sanches Bocato. All rights reserved.
//

import UIKit

class DestructiveCell: UITableViewCell, ThemeObserving {

    // MARK: - Enums
    
    enum DestructiveCellStyle {
        case deleteAll
    }
    
    // MARK: - Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        loadCurrentTheme()
        addThemeObserver()
    }
    
    deinit {
        removeThemeObserver()
    }
    
    // MARK: - Functions
    
    func configured(as style: DestructiveCellStyle) -> Self {
        switch style {
        case .deleteAll:
            textLabel?.text = "Delete all favorites"
            textLabel?.textColor = .red
        }
        
        return self
    }
    
}

extension DestructiveCell: Themeable {
    
    func apply(_ theme: ThemeType) {
        backgroundColor = theme.cellBackgroundColor
        setNeedsDisplay()
    }
    
}
