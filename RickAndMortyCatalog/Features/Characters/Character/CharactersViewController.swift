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

    let characters: [RMCharacter] = [
        RMCharacter(id: 12, name: "character name", status: "character status", species: "character species", type: "character type", gender: "character gender", origin: RMCharacterOrigin(name: "character origin name", url: nil), location: RMCharacterLocation(name: "character location name", url: nil), image: nil, episode: nil, url: nil, created: nil)
    ]
    
//    var characters = [RMCharacter]() {
//        didSet {
//            tableView.reloadData()
//        }
//    }
    
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
                destination.character = characters[0]
            }
        }
    
    // MARK: - Functions
    
    private func dowloadCharacters() {
//        service.getAllCharacters { [weak self] (result) in
//            switch result {
//            case .success(let response):
//                self?.characters = response
//                
//            default: return
//            }
//        }
    }
    
    // MARK: - Configuration Functions
    
    private func loadViewData() {
        // @TODO: if there are downloaded characters, get them from Realm. if there aren't, download them
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
    
}

extension CharactersViewController: UITableViewDelegate {
    
    // MARK: - Table View Delegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "CharacterDetailSegue", sender: self)
    }
    
}
