//
//  SwitchCell.swift
//  RickAndMortyCatalog
//
//  Created by Andre Sanches Bocato on 13/05/19.
//  Copyright © 2019 Andre Sanches Bocato. All rights reserved.
//

import UIKit

class SwitchCell: UITableViewCell, ThemeObserving {
    
    // MARK: - IBOutlets
    
    @IBOutlet private weak var cellTitleLabel: UILabel! {
        didSet {
            cellTitleLabel.text = "Switch to dark theme"
        }
    }
    @IBOutlet private weak var themeSwitch: UISwitch!
    
    // MARK: - Private Properties
    
    private var onSwitchValueChanged: ((_ isOn: Bool) -> Void)?
    
    // MARK: - Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        loadCurrentTheme()
        addThemeObserver()
    }
    
    deinit {
        removeThemeObserver()
    }
    
    // MARK: - IBActions
    
    @IBAction private func switchValueChanged(_ sender: UISwitch) {
        onSwitchValueChanged?(sender.isOn)
        UISelectionFeedbackGenerator().selectionChanged()
    }
    
    // MARK: - Public Functions
    
    public func configure(isSwitchOn: Bool, onSwitchValueChanged: ((_ isOn: Bool) -> Void)?) {
        selectionStyle = .none
        themeSwitch.isOn = isSwitchOn
        self.onSwitchValueChanged = onSwitchValueChanged
    }
    
}

// MARK: - Themeable

extension SwitchCell: Themeable {
    
    func apply(_ theme: ThemeType) {
        cellTitleLabel.textColor = theme.textColor
        themeSwitch.onTintColor = theme.selectedButtonColor
        backgroundColor = theme.cellBackgroundColor
        setNeedsDisplay()
    }
    
}
