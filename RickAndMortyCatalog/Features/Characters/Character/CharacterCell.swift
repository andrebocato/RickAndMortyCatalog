//
//  CharacterCell.swift
//  RickAndMortyCatalog
//
//  Created by Andre Sanches Bocato on 15/04/19.
//  Copyright © 2019 Andre Sanches Bocato. All rights reserved.
//

import UIKit

class CharacterCell: UITableViewCell {
    
    // MARK: - IBOutlets
    
    @IBOutlet private weak var cellImageView: UIImageView!
    @IBOutlet private weak var idLabel: UILabel!
    @IBOutlet private weak var nameLabel: UILabel!
    
    // MARK: - Lifecycle
    
    override func prepareForReuse() {
        super.prepareForReuse()
        cellImageView.startLoading()
    }
    
    // MARK: - Configuration Functions
    
    func configure(with character: RMCharacter) {
        cellImageView.image = UIImage() // @TODO: should get image from character
        idLabel.text = " #\(character)"
        nameLabel.text = character.name
        stopLoading()
    }
    
}
