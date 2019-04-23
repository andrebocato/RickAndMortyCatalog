//
//  CharactersViewController.swift
//  RickAndMortyCatalog
//
//  Created by Andre Sanches Bocato on 09/04/19.
//  Copyright © 2019 Andre Sanches Bocato. All rights reserved.
//

import Foundation
import UIKit

class CharactersViewController: UIViewController {
    
    // MARK: - Dependencies
    
    private let service: RMCharactersServiceProtocol = RMCharactersServiceMock()
    
    // MARK: - IBOutlets
    
    @IBOutlet private weak var tableView: UITableView! {
        didSet {
            tableView.dataSource = self
            tableView.delegate = self
        }
    }
    
    // MARK: - IBActions
    
    // MARK: - Properties

    private let cellHeight: CGFloat = 80
    
    private var characters = [RMCharacter]() {
        didSet {
            tableView.reloadData()
        }
    }
    private var selectedCharacter: RMCharacter! // why is this forced?
    
    // MARK: - Initilization
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadViewData()
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destination = segue.destination as? CharacterDetailViewController, segue.destination is CharacterDetailViewController else { return }
        
        if segue.identifier == "CharacterDetailSegue" {
            destination.character = selectedCharacter
        }
    }
    
    // MARK: - Functions
    
    private func dowloadCharacters() {
        service.getAllCharacters { [weak self] (result) in
            switch result {
            case .success(let response):
                self?.characters = response

            default: return
            }
        }
    }
    
    // MARK: - Configuration Functions
    
    private func loadViewData() {
        dowloadCharacters()
        // @TODO: if there are downloaded characters, get them from persisted data. if there aren't, download them
    }
    
    // MARK: - Helper Functions
}

// MARK: - Extensions

extension CharactersViewController: UITableViewDataSource {
    
    // MARK: - Table View Data Source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return characters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CharacterCell.identifier, for: indexPath) as? CharacterCell else { return UITableViewCell() }
        
        let character = characters[indexPath.row]
        cell.configure(with: character)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeight
    }
    
}

extension CharactersViewController: UITableViewDelegate {
    
    // MARK: - Table View Delegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        selectedCharacter = characters[indexPath.row]
        performSegue(withIdentifier: "CharacterDetailSegue", sender: self)
    }
    
}
