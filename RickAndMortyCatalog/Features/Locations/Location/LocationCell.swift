//
//  LocationCell.swift
//  RickAndMortyCatalog
//
//  Created by Andre Sanches Bocato on 09/04/19.
//  Copyright © 2019 Andre Sanches Bocato. All rights reserved.
//

import UIKit

class LocationCell: UITableViewCell {
    
    // MARK: - IBOutlets
    
    @IBOutlet private weak var locationImageView: UIImageView!
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
    func configureWith(_ image: UIImage,
                       _ name: String,
                       _ id: Int) {
        
        locationImageView.image = image
        idLabel.text = "\(id)"
        nameLabel.text = name
    }
    
    // MARK: - Helper Functions
    
}
