//
//  FavoriteFilterCell.swift
//  RickAndMortyCatalog
//
//  Created by Andre Sanches Bocato on 22/05/19.
//  Copyright © 2019 Andre Sanches Bocato. All rights reserved.
//

import UIKit

class FilterCell: UICollectionViewCell, ThemeObserving {

    // MARK: - IBOutlets
    
    @IBOutlet private weak var filterLabel: UILabel! {
        didSet {
            filterLabel.font = .cartoonToy(ofSize: 25)
        }
    }
    
    var theme: ThemeType!
    
    override var isSelected: Bool {
        didSet {
            backgroundColor = isSelected ? theme.tabBarColor : theme.viewBackgroundColor
            filterLabel.textColor = isSelected ? theme.selectedButtonColor : theme.unselectedButtonColor
        }
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
    
    // MARK: - Public Functions
    
    public func configured(withTitle title: String) -> FilterCell {
        filterLabel.text = title
        return self
    }
    
}

// MARK: - Extensions

extension FilterCell: Themeable {
    
    func apply(_ theme: ThemeType) {
        backgroundColor = isSelected ? theme.tabBarColor : theme.viewBackgroundColor
        filterLabel.textColor = isSelected ? theme.selectedButtonColor : theme.unselectedButtonColor
        self.theme = theme
    }
    
}
