//
//  DestructiveCell.swift
//  RickAndMortyCatalog
//
//  Created by Andre Sanches Bocato on 13/05/19.
//  Copyright © 2019 Andre Sanches Bocato. All rights reserved.
//

import UIKit

class DestructiveCell: UITableViewCell {

    // MARK: - Enums
    
    enum DestructiveCellStyle {
        case deleteAll
    }
    
    // MARK: - Functions
    
    func configured(as style: DestructiveCellStyle) -> Self {
        switch style {
        case .deleteAll:
            textLabel?.text = "Delete all favorites"
            textLabel?.textColor = .red
        }
        
        return self
    }
    
}
