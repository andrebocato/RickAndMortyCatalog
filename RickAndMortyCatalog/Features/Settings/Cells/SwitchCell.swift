//
//  SwitchCell.swift
//  RickAndMortyCatalog
//
//  Created by Andre Sanches Bocato on 13/05/19.
//  Copyright © 2019 Andre Sanches Bocato. All rights reserved.
//

import UIKit

class SwitchCell: UITableViewCell {

    // MARK: - Enums
    
    enum SwitchCellStyle {
        case darkTheme
    }

    // MARK: - IBOUtlets
    
    @IBOutlet private weak var themeSwitch: UISwitch!
    
    // MARK: - Functions
    
    func configured(as style: SwitchCellStyle) -> SwitchCell {
        switch style {
        case .darkTheme:
            textLabel?.text = "Switch to dark theme"
        }
        
        return self
    }
    
}
