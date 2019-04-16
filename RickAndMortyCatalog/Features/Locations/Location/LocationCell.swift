//
//  LocationCell.swift
//  RickAndMortyCatalog
//
//  Created by Andre Sanches Bocato on 15/04/19.
//  Copyright © 2019 Andre Sanches Bocato. All rights reserved.
//

import UIKit

class LocationCell: UITableViewCell, LoadableView {
    
    // MARK: - IBOutlets
    
    @IBOutlet private weak var idLabel: UILabel!
    @IBOutlet private weak var nameLabel: UILabel!
    
    // MARK: - Configuration Functions
    
    func configure(with location: RMLocation) {
        idLabel.text = " #\(location)"
        nameLabel.text = location.name
    }
}
