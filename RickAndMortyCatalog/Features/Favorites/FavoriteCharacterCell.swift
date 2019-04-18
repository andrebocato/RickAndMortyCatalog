//
//  FavoriteCell.swift
//  RickAndMortyCatalog
//
//  Created by Andre Sanches Bocato on 15/04/19.
//  Copyright © 2019 Andre Sanches Bocato. All rights reserved.
//

import UIKit

class FavoriteCharacterCell: UICollectionViewCell {
 
    // MARK: - IBOutlets
    
    @IBOutlet private weak var imageView: UIImageView! {
        didSet {
            imageView.layer.cornerRadius = 8.0 // @TODO: create custom image view with rounded corners
        }
    }
    
    // MARK: - Lifecycle
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = UIImage()
        imageView.startLoading()
    }
    
    // MARK: - Configuration Functions
    
    func configure(with character: RMCharacter) {
        imageView.image = UIImage() // @TODO: character.image
        
        imageView.stopLoading()
    }
}
