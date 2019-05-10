//
//  CharacterCell.swift
//  RickAndMortyCatalog
//
//  Created by Andre Sanches Bocato on 23/04/19.
//  Copyright © 2019 Andre Sanches Bocato. All rights reserved.
//

import UIKit

class CharacterCell: UITableViewCell {

    // MARK: - IBOutlets

    @IBOutlet private weak var cellImageView: UIImageView! {
        didSet {
            cellImageView.layer.cornerRadius = 10
        }
    }
    
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var idLabel: UILabel!
    
    // MARK: - Private Properties
    
    private var modelController: RMCharacterModelController!
    private var onFavoriteErrorCallBack: ((_ error: Error) -> Void)?
    
    // MARK: - Lifecycle
    
    override func prepareForReuse() {
        super.prepareForReuse()
        cellImageView.image = UIImage()
        modelController.cancelImageRequest()
    }
    
    // MARK: - Configuration Functions
    
    /// Configures the cell with data.
    ///
    /// - Parameter modelController: The modelController that refers to a RMCharacter.
    func configure(with modelController: RMCharacterModelController, onFavoriteErrorCallBack: ((_ error: Error) -> Void)? = nil) {
        self.modelController = modelController
        self.modelController.delegate = self
        self.onFavoriteErrorCallBack = onFavoriteErrorCallBack
        setupUI()
    }
        
    // MARK: - Private Functions
    
    private func setupUI() {
        setupImage()
        setupLabels()
        setupCellColors()
    }
    
    private func setupImage() {
        modelController.fetchImageData { [weak self] (data) in
            DispatchQueue.main.async {
                self?.cellImageView.image = UIImage(data: data)
            }
        }
    }
    
    private func setupLabels() {
        idLabel.text = " #\(modelController.character.id)"
        nameLabel.text = modelController.character.name
    }
    
    private func setupCellColors() {
        let coloredView = UIView()
        coloredView.backgroundColor = UIColor(red: 0.75, green: 0.80, blue: 0.93, alpha: 1.0) // magic color?
        selectedBackgroundView = coloredView
    }
        
}

// MARK: - Extensions

extension CharacterCell: RMCharacterModelControllerDelegate {

    // MARK: - RMCharacter Model Controller Delegate
    
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
    
    private func handleLoadingImageState(_ loading: Bool) { // @TODO: Check this...
//        DispatchQueue.main.async {
//            loading ? self.cellImageView.startLoading(style: .white) : self.cellImageView.stopLoading()
//        }
    }
    
    private func handleBusinessError(_ error: Error) {
        onFavoriteErrorCallBack?(error)
    }
    
}
