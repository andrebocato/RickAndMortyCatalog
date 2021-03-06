//
//  CharacterCell.swift
//  RickAndMortyCatalog
//
//  Created by Andre Sanches Bocato on 23/04/19.
//  Copyright © 2019 Andre Sanches Bocato. All rights reserved.
//

import UIKit

class CharacterCell: UITableViewCell, ThemeObserving {
    
    // MARK: - IBOutlets
    
    @IBOutlet private weak var cellImageView: UIImageView! {
        didSet {
            cellImageView.layer.cornerRadius = 10
        }
    }
    @IBOutlet private weak var nameLabel: UILabel! {
        didSet {
            nameLabel.font = .laCartoonerie(ofSize: 20.0)
        }
    }
    @IBOutlet private weak var idLabel: UILabel! {
        didSet {
            idLabel.font = .laCartoonerie(ofSize: 25.0)
        }
    }
    @IBOutlet private weak var favoriteImageView: UIImageView!
    
    // MARK: - Private Properties
    
    private var modelController: RMCharacterModelController!
    private var onFavoriteErrorCallBack: ((_ error: Error) -> Void)?
    
    // MARK: - Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        addThemeObserver()
        loadCurrentTheme()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        cellImageView.image = UIImage()
        modelController.cancelImageRequest()
    }
    
    deinit {
        removeThemeObserver()
    }
    
    // MARK: - Public Functions
    
    /// Configures the cell with data.
    ///
    /// - Parameters:
    ///   - modelController: The modelController that refers to a RMCharacter.
    ///   - onFavoriteErrorCallBack: Closure executed in case of error toggling a character as favorite.
    public func configure(with modelController: RMCharacterModelController, onFavoriteErrorCallBack: ((_ error: Error) -> Void)? = nil) {
        self.modelController = modelController
        self.modelController.delegate = self
        self.onFavoriteErrorCallBack = onFavoriteErrorCallBack
        setupUI()
    }
    
    // MARK: - Private Functions
    
    private func setupUI() {
        setupImageView()
        setupLabels()
        setupIsFavoriteImageView()
    }
    
    private func setupImageView() {
        modelController.fetchImageData { [weak self] (data) in
            DispatchQueue.main.async {
                self?.cellImageView.image = UIImage(data: data)
            }
        }
    }
    
    private func setupLabels() {
        idLabel.text = "#\(modelController.character.id)"
        nameLabel.text = modelController.character.name
    }
    
    private func setupIsFavoriteImageView() {
        let isFavoriteImageName = modelController.isFavorite ? "favorited" : "unfavorited"
        favoriteImageView.image = UIImage(named: isFavoriteImageName)
    }
    
}

// MARK: - Model Controller Delegate

extension CharacterCell: RMCharacterModelControllerDelegate {
    
    func allCharactersWereDeleted() {
        setupUI()
    }
    
    func stateDidChange(_ newState: RMCharacterModelControllerState) {
        switch newState {
        case .loadingImage(let value): handleLoadingImageState(value)
        case .businessError(let error): handleBusinessError(error)
        default: return
        }
    }
    
    // @TODO: fix. not working
    private func handleLoadingImageState(_ loading: Bool) {
        //        DispatchQueue.main.async {
        //            loading ? self.cellImageView.startLoading(style: .white) : self.cellImageView.stopLoading()
        //        }
    }
    
    private func handleBusinessError(_ error: Error) {
        onFavoriteErrorCallBack?(error)
    }
    
}

extension CharacterCell: Themeable {
    
    func apply(_ theme: ThemeType) {
        backgroundColor = theme.viewBackgroundColor
        idLabel.textColor = theme.titleTextColor
        nameLabel.textColor = theme.textColor
        favoriteImageView.tintColor = theme.selectedButtonColor
        
        let coloredView = UIView()
        coloredView.backgroundColor = theme.selectedCellBackgroundColor 
        selectedBackgroundView = coloredView
        
        setNeedsDisplay()
    }
    
}
