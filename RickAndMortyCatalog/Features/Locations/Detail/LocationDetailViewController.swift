//
//  LocationDetailViewController.swift
//  RickAndMortyCatalog
//
//  Created by Andre Sanches Bocato on 09/04/19.
//  Copyright © 2019 Andre Sanches Bocato. All rights reserved.
//

import Foundation
import UIKit

class LocationDetailViewController: UIViewController {
    
    // MARK: - Dependencies
    
    private let service: RMCharactersServiceProtocol = RMCharactersServiceMock()
    
    // MARK: - IBOutlets
    
    @IBOutlet private weak var toggleFavoriteBarButtonItem: UIBarButtonItem!
    @IBOutlet private weak var expandButton: UIButton!
    
    @IBOutlet private weak var idFixedLabel: UILabel!
    @IBOutlet private weak var nameFixedLabel: UILabel!
    @IBOutlet private weak var typeFixedLabel: UILabel!
    @IBOutlet private weak var dimensionFixedLabel: UILabel!
    @IBOutlet private weak var residentsFixedLabel: UILabel!
    
    @IBOutlet private weak var idLabel: UILabel!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var typeLabel: UILabel!
    @IBOutlet private weak var dimensionLabel: UILabel!
    @IBOutlet private weak var residentsLabel: UILabel!
    
    // MARK: - IBActions
    
    @IBAction private func toggleFavoriteBarButtonItemDidReceiveTouchUpInside(_ sender: Any) {
        // @TODO: if character is favorite, switch image and delete persisted data. else, set isFavorite to true and persist data.
    }
    
    @IBAction private func expandButtonDidReceiveTouchUpInside(_ sender: Any) {
        // @TODO: load list of residents, disable
        // @TODO: clicking anywhere disables this state
    }
    
    // MARK: - Properties
    
    var location: RMLocation!
    var residentsNames = [String]()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView(with: location)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.toolbar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.toolbar.isHidden = false
    }
    
    // MARK: - Functions
    
    private func persistFavorite() {
        // @TODO: implement
    }
    
    private func deletePersistedFavorite() {
        // @TODO: implement
    }
    
    // MARK: - Configuration Functions
    
    private func configureView(with location: RMLocation) {
        idLabel.text = "\(location.id ?? 00)"
        nameLabel.text = location.name
        typeLabel.text = location.type
        dimensionLabel.text = location.dimension
        residentsLabel.text = "\(location.residents?.count ?? 0)"
    }
    
    // MARK: - Helper Functions
    
    private func listResidents(from location: RMLocation) {
        for id in location.residentIDs() {
            service.getCharacter(withID: id) { [weak self] (result) in
                switch result {
                case .success(let response):
                    if let name = response.name {
                        self?.residentsNames.append(name)
                    }
                case .failure(let error):
                    ErrorHelper.logServiceError(error)
                }
            }
        }
    }
    
}
