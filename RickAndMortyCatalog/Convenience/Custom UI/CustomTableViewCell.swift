//
//  CustomTableViewCell.swift
//  RickAndMortyCatalog
//
//  Created by Andre Sanches Bocato on 09/04/19.
//  Copyright © 2019 Andre Sanches Bocato. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    private var customImageView: UIImageView!
    private var idLabel: UILabel!
    private var nameLabel: UILabel!
    
    // MARK: - Configuration
    
    /// Configures the selected cell.
    ///
    /// - Parameters:
    ///   - image: Image used to populate the Image View in the cell.
    ///   - name: String used to populate the Name Label in the cell.
    ///   - id: Int used to populate the ID Label in the cell.
    private func configureWith(_ image: UIImage,
                               _ name: String,
                               _ id: Int) {
        
        customImageView.image = image
        idLabel.text = "\(id)"
        nameLabel.text = name
    }
    
}
