//
//  FavoriteCell.swift
//  RickAndMortyCatalog
//
//  Created by Andre Sanches Bocato on 15/04/19.
//  Copyright © 2019 Andre Sanches Bocato. All rights reserved.
//

import UIKit

class FavoriteCell: UICollectionViewCell {
 
    // MARK: - IBOutlets
    
    @IBOutlet private weak var imageView: UIImageView!
    
    // MARK: - Lifecycle
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = UIImage()
        imageView.startLoading()
    }
    
    // MARK: - Configuration Functions
    
    func configure(with character: RMCharacter) {
        imageView.image = UIImage(named: "MockImage")
        
        imageView.stopLoading()
    }
}
