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

    // MARK: - Properties
    
    private var isDarkThemeApplied = Bool()
    
    // MARK: - Functions
    
    func configured(as style: SwitchCellStyle) -> SwitchCell {
        switch style {
        case .darkTheme:
            textLabel?.text = "Switch to dark theme"
            
            let themeSwitch = UISwitch(frame: .zero)
            themeSwitch.isOn = false
            themeSwitch.addTarget(self, action: #selector(switchValueChanged(_:)), for: .valueChanged)
            accessoryView = themeSwitch
        }
        
        return self
    }
 
    // MARK: - Actions
    
    // @TODO: implement properly
    @objc func switchValueChanged(_ sender: UISwitch) {
        if sender.isOn {
            isDarkThemeApplied = !isDarkThemeApplied
        } else {
            backgroundColor = .white
            textLabel?.textColor = .black
        }
    }
    
}
