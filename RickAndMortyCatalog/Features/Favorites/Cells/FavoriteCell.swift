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
    
    // MARK: - Private Properties
    
    private var imageFetcher: RMCharacterImageFetcherProtocol?
    
    // MARK: - Lifecycle
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageFetcher?.cancelImageRequest()
        imageView.startLoading(style: .gray)
    }
    
    // MARK: - Public Functions
    
    public func configure(with imageFetcher: RMCharacterImageFetcherProtocol) {
        self.imageFetcher = imageFetcher
        loadImage()
    }
    
    // MARK: - Private Functions
    
    private func loadImage() {
        imageFetcher?.fetchImageData { [weak self] (data) in
            self?.imageView.image = UIImage(data: data)
            self?.imageView.stopLoading()
        }
    }
    
}
