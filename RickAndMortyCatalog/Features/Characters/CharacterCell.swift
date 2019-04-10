//
//  CharacterCell.swift
//  RickAndMortyCatalog
//
//  Created by Andre Sanches Bocato on 09/04/19.
//  Copyright © 2019 Andre Sanches Bocato. All rights reserved.
//

import UIKit

class CharacterCell: UITableViewCell {

    // MARK: - IBOutlets
    
    @IBOutlet private weak var characterImageView: UIImageView!
    @IBOutlet private weak var idLabel: UILabel!
    @IBOutlet private weak var nameLabel: UILabel!
    
    // MARK: - IBActions
    
    // MARK: - Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    // MARK: - Configuration
    
    /// Configures the selected cell.
    func configureWith() {
        // @TODO: implement configuration
    }
    
    // MARK: - Helper Functions
    
}
