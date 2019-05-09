//
//  DetailViewController.swift
//  RickAndMortyCatalog
//
//  Created by Andre Sanches Bocato on 09/04/19.
//  Copyright © 2019 Andre Sanches Bocato. All rights reserved.
//
// @TODO: set text as "-" when result is ""

import Foundation
import UIKit
import RealmSwift

class DetailViewController: UIViewController {
    
    // MARK: - Dependencies
    
    private var logicController: DetailLogicController
    
    // MARK: - IBOutlets
    
    @IBOutlet private weak var idFixedLabel: UILabel!
    @IBOutlet private weak var nameFixedLabel: UILabel!
    @IBOutlet private weak var statusFixedLabel: UILabel!
    @IBOutlet private weak var speciesFixedLabel: UILabel!
    @IBOutlet private weak var typeFixedLabel: UILabel!
    @IBOutlet private weak var genderFixedLabel: UILabel!
    @IBOutlet private weak var originNameFixedLabel: UILabel!
    @IBOutlet private weak var locationNameFixedLabel: UILabel!
    
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var idLabel: UILabel!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var statusLabel: UILabel!
    @IBOutlet private weak var speciesLabel: UILabel!
    @IBOutlet private weak var typeLabel: UILabel!
    @IBOutlet private weak var genderLabel: UILabel!
    @IBOutlet private weak var originLabel: UILabel!
    @IBOutlet private weak var locationLabel: UILabel!
    
    // MARK: - Initialization
    
    init(nibName nibNameOrNil: String?,
         bundle nibBundleOrNil: Bundle?,
         logicController: DetailLogicController) {
        self.logicController = logicController
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.logicController.delegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createBarButtonItem()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.toolbar.isHidden = true
        navigationController?.tabBarController?.tabBar.isHidden = true
        setupViewData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.toolbar.isHidden = false
        navigationController?.tabBarController?.tabBar.isHidden = false
    }
    
    // MARK: - UI
    
    private func createBarButtonItem() {
        let barButtonItem = UIBarButtonItem(image:  UIImage(named: "unfavorited"), style: .done, target: self, action: #selector(toggleFavoriteBarButtonItemDidReceiveTouchUpInside(_:)))
        navigationItem.rightBarButtonItem = barButtonItem
    }
    
    private func setupViewData() {
        setupImageView()
        setupLabelsText()
        updateBarButtonImage()
        view.setNeedsDisplay()
    }
    
    private func setupImageView() {
        imageView.startLoading()
        logicController.fetchImageData { [weak self] (imageData) in
            DispatchQueue.main.async {
                self?.imageView.image = UIImage(data: imageData)
                self?.imageView.stopLoading()
            }
        }
    }
    
    private func setupLabelsText() {
        idLabel.text = "\(logicController.character.id)"
        nameLabel.text = logicController.character.name
        statusLabel.text = logicController.character.status
        statusLabel.text = logicController.character.status
        speciesLabel.text = logicController.character.species
        typeLabel.text = logicController.character.type
        genderLabel.text = logicController.character.gender
        originLabel.text = logicController.character.origin.name
        locationLabel.text = logicController.character.location.name
    }
    
    private func updateBarButtonImage() {
        guard let barButtonItem = navigationItem.rightBarButtonItem else { return }
        let buttonImageName = logicController.isFavoriteCharacter ? "favorited" : "unfavorited"
        barButtonItem.image = UIImage(named: buttonImageName)
    }
    
    // MARK: - Actions
    
    @objc private func toggleFavoriteBarButtonItemDidReceiveTouchUpInside(_ sender: UIBarButtonItem) {
        logicController.toggleFavorite()
    }
    
}

extension DetailViewController: DetailLogicControllerDelegate {
    
    func favoriteStateChanged(_ isFavorite: Bool) {
        updateBarButtonImage()
    }
    
    func stateDidChange(_ newState: DetailLogicControllerState) {
        switch newState {
        case .error(let e): handleError(e)
        case .loadingImage(let value): handleLoadingImageState(value)
        }
    }
    
    // MARK: - State Handlers
    
    private func handleLoadingImageState(_ loading: Bool) {
        loading ? imageView.startLoading() : imageView.stopLoading()
    }
    
    private func handleError(_ error: Error) {
        AlertHelper.presentAlert(inController: self, title: "Error!", message: error.localizedDescription) { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        }
    }
    
}
