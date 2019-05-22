//
//  FavoriteFilterCell.swift
//  RickAndMortyCatalog
//
//  Created by Andre Sanches Bocato on 22/05/19.
//  Copyright © 2019 Andre Sanches Bocato. All rights reserved.
//

import UIKit

class FavoriteFilterCell: UICollectionViewCell, ThemeObserving {

    // MARK: - IBOutlets
    
    @IBOutlet private weak var titleLabel: UILabel!
    
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
    
    public func configured(withTitle title: String) -> FavoriteFilterCell {
        titleLabel.text = title
    }

}

// MARK: - Extensions

extension FavoriteFilterCell: Themeable {
    
    func apply(theme: ThemeType) {
        backgroundColor = theme.cellBackgroundColor
        titleLabel.textColor = theme.titleTextColor
    }
    
}
