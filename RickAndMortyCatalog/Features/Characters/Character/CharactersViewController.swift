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

    private let service: RMCharactersServiceProtocol
    
    // MARK: - IBOutlets
    
    @IBOutlet private weak var tableView: UITableView! {
        didSet {
            tableView.dataSource = self
            tableView.delegate = self
        }
    }
    
    // MARK: - Properties

    private let cellHeight: CGFloat = 80
    
    private var characters = [RMCharacter]() {
        didSet {
            DispatchQueue.main.async { self.tableView.reloadData() }
        }
    }
    
    private var currentPage = 1
    private var pages: Int
    
    // MARK: - Initilization
    
    init(nibName nibNameOrNil: String?,
         bundle nibBundleOrNil: Bundle?,
         service: RMCharactersServiceProtocol,
         currentPage: Int,
         pages: Int) {
        self.service = service
        self.currentPage = currentPage
        self.pages = pages
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerTableViewCells()
        downloadResponse(forPage: 1)
    }
    
    // MARK: - UI
    
    private func registerTableViewCells() {
        let bundle = Bundle(for: CharacterCell.self)
        let className = CharacterCell.className
        let cellNib = UINib(nibName: className, bundle: bundle)
        tableView.register(cellNib, forCellReuseIdentifier: className)
    }

    // MARK: - Functions
    
    private func downloadResponse(forPage page: Int) {
        service.getAllCharacters(onPage: page) { [weak self] (result) in
            switch result {
            case .success(let response):
                guard let characters = self?.characters else { return }
                if characters.count == 0 {
                    self?.characters = response.results
                } else {
                    self?.characters += response.results // @TODO: filter characters that already exist in the array
                }
                self?.pages = response.info.pages
            default: return
            }
        }
    }
    
    // MARK: - Configuration Functions
    
}

// MARK: - Extensions

extension CharactersViewController: UITableViewDataSource {
    
    // MARK: - Table View Data Source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return characters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CharacterCell.className, for: indexPath) as? CharacterCell else { return UITableViewCell() }
        
        let character = characters[indexPath.row]
        cell.configure(with: character)
        tableView.stopLoading()
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeight
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//        if indexPath.row == characters.count {
//            currentPage += 1
//            downloadResponse(forPage: currentPage)
//        }
    }
    
}

extension CharactersViewController: UITableViewDelegate {
    
    // MARK: - Table View Delegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        let selectedCharacter = characters[indexPath.row]
        
        let detailsController = CharacterDetailViewController(nibName: CharacterDetailViewController.className,
                                                              bundle: Bundle(for: CharacterDetailViewController.self),
                                                              service: DependencyInjection.charactersService,
                                                              character: selectedCharacter)
        navigationController?.pushViewController(detailsController, animated: true)
    }
    
}
