//
//  CharacterCell.swift
//  RickAndMortyCatalog
//
//  Created by Eduardo Sanches Bocato on 23/04/19.
//  Copyright © 2019 Andre Sanches Bocato. All rights reserved.
//

import UIKit

class CharacterCell: UITableViewCell {

    // MARK: - IBOutlets

    @IBOutlet private weak var cellImageView: UIImageView! {
        didSet {
            cellImageView.layer.cornerRadius = 10
        }
    }
    
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var idLabel: UILabel!
    
    // MARK: - Lifecycle
    
    override func prepareForReuse() {
        super.prepareForReuse()
        requestToken?.cancel()
    }
    
    //
    
    // MARK: - Configuration Functions
    
    func configure(with character: RMCharacter) {
        loadImage(for: character)
        idLabel.text = " #\(character.id)"
        nameLabel.text = character.name
        
    }
    
    // For Tests
    private var requestToken: URLRequestToken?
    
    private func loadImage(for character: RMCharacter) {
        
        let service = DependencyInjection.imageService
        
        cellImageView.startLoading()
        
        let imageURL = character.image
        requestToken = service.getImageDataFromURL(imageURL) { [weak self] (result) in
            self?.cellImageView.stopLoading()
            
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    self?.cellImageView.image = UIImage(data: data)
                }
            case .failure(let error):
                debugPrint(error)
            }
            
            
        }
        
    }
    
    // For Tests

    
}
