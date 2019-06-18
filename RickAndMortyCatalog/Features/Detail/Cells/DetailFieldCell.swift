//
//  DetailFieldCell.swift
//  RickAndMortyCatalog
//
//  Created by Andre Sanches Bocato on 28/05/19.
//  Copyright © 2019 Andre Sanches Bocato. All rights reserved.
//

import UIKit

class DetailFieldCell: UITableViewCell, ThemeObserving {

    // MARK: - IBOutlets
    
    @IBOutlet private weak var titleFieldLabel: UILabel! {
        didSet {
            titleFieldLabel.font = .laCartoonerie(ofSize: 17)
        }
    }
    @IBOutlet private weak var fieldPlaceholderLabel: UILabel! {
        didSet {
            fieldPlaceholderLabel.font = .laCartoonerie(ofSize: 15)
        }
    }
    
    // MARK: - Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        loadCurrentTheme()
        addThemeObserver()
    }
    
    deinit {
        removeThemeObserver()
    }
    
    // MARK: - Functions
    
    func configured(with character: RMCharacter, field: DetailFields) -> Self {
        titleFieldLabel?.text = field.stringValue
        switch field {
        case .id: fieldPlaceholderLabel?.text = "\(character.id)"
        case .name: fieldPlaceholderLabel?.text = character.name
        case .status: fieldPlaceholderLabel?.text = character.status.rawValue
        case .species: fieldPlaceholderLabel?.text = character.species
        case .type: fieldPlaceholderLabel?.text = !character.type.isEmpty ? character.type : "-"
        case .gender: fieldPlaceholderLabel?.text = character.gender
        case .origin: fieldPlaceholderLabel?.text = character.origin.name
        case .location: fieldPlaceholderLabel?.text = character.location.name
        }
        return self
    }
    
}

extension DetailFieldCell: Themeable {
    
    func apply(_ theme: ThemeType) {
        titleFieldLabel?.textColor = theme.titleTextColor
        fieldPlaceholderLabel?.textColor = theme.textColor
        backgroundColor = theme.viewBackgroundColor
        setNeedsDisplay()
    }
    
}
