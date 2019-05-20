//
//  SwitchCell.swift
//  RickAndMortyCatalog
//
//  Created by Andre Sanches Bocato on 13/05/19.
//  Copyright © 2019 Andre Sanches Bocato. All rights reserved.
//

import UIKit

class SwitchCell: UITableViewCell {

    // MARK: - IBOutlets
    
    @IBOutlet private weak var cellTitleLabel: UILabel! {
        didSet {
            cellTitleLabel.text = "Switch to dark theme"
        }
    }
    
    @IBOutlet private weak var themeSwitch: UISwitch! {
        didSet {
            themeSwitch.isOn = userDefaults.isDarkThemeOn()
        }
    }
    
    // MARK: - Properties
    
    private var onSwitchValueChanged: ((_ isOn: Bool) -> Void)?
    private let userDefaults = UserDefaultsManager()
    
    // MARK: - IBActions
    
    @IBAction func switchValueChanged(_ sender: UISwitch) {
        onSwitchValueChanged?(sender.isOn)
        userDefaults.setDarkThemeOn(sender.isOn)
    }
    
    // MARK: - Public Functions
    
    func configure(onSwitchValueChanged: ((_ isOn: Bool) -> Void)?) {
        selectionStyle = .none
        self.onSwitchValueChanged = onSwitchValueChanged
    }
    
}
