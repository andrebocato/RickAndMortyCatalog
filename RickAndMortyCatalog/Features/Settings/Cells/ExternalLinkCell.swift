//
//  ExternalLinkCell.swift
//  RickAndMortyCatalog
//
//  Created by Andre Sanches Bocato on 13/05/19.
//  Copyright © 2019 Andre Sanches Bocato. All rights reserved.
//

import UIKit

class ExternalLinkCell: UITableViewCell {

    // MARK: - Enums
    
    enum ExternalLinkCellStyle {
        case githubRepo
        case apiDocumentation
    }
    
    // MARK: - Functions
    
    func configured(as style: ExternalLinkCellStyle) -> Self {
        accessoryType = .disclosureIndicator

        switch style {
        case .githubRepo:
            textLabel?.text = "Source code"
        case .apiDocumentation:
            textLabel?.text = "API Documentation"
        }
        
        return self
    }
    
}
