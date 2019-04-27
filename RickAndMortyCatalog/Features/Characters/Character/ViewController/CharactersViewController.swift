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
    
    private let logicController: CharactersLogicController
    private let viewControllersFactory: ViewControllersFactoryProtocol
    
    // MARK: - IBOutlets
    
    @IBOutlet private weak var tableView: UITableView! {
        didSet {
            tableView.dataSource = self
            tableView.delegate = self
        }
    }
    
    // MARK: - Properties

    private let cellHeight: CGFloat = 80
    
    // MARK: - Initialization
    
    init(nibName nibNameOrNil: String?,
         bundle nibBundleOrNil: Bundle?,
         logicController: CharactersLogicController,
         viewControllersFactory: ViewControllersFactoryProtocol) {
        self.logicController = logicController
        self.viewControllersFactory = viewControllersFactory
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerTableViewCells()
        logicController.loadCharacters()
    }
    
    // MARK: - UI Setup
    
    private func registerTableViewCells() {
        let bundle = Bundle(for: CharacterCell.self)
        let className = CharacterCell.className
        let cellNib = UINib(nibName: className, bundle: bundle)
        tableView.register(cellNib, forCellReuseIdentifier: className)
    }

}

// MARK: - Extensions

extension CharactersViewController: UITableViewDataSource {
    
    // MARK: - Table View Data Source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return logicController.numberOfCharacters
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CharacterCell.className, for: indexPath) as? CharacterCell else { return UITableViewCell() }
        
        let modelController = logicController.modelController(for: indexPath.row)
        cell.configure(with: modelController, onFavoriteErrorCallBack: { [weak self] (error) in
            AlertHelper.showAlert(inController: self, title: "Persistence Error!", message: error.localizedDescription)
        })
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeight
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastRowIndex = logicController.numberOfCharacters - 1
        if indexPath.row == lastRowIndex {
            logicController.loadNextCharactersPage()
        }
    }
    
}

extension CharactersViewController: UITableViewDelegate {
    
    // MARK: - Table View Delegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let selectedCharacterModelController = logicController.modelController(for: indexPath.row)
        let detailController = viewControllersFactory.createDetailsViewController(characterModelController: selectedCharacterModelController)
        navigationController?.pushViewController(detailController, animated: true)
    }
    
}

extension CharactersViewController: CharactersLogicControllerDelegate {
 
    // MARK: - Characters Logic Controller Delegate
    
    func stateDidChange(_ newState: CharactersLogicControllerState) {
        switch newState {
        case .loadingCharacters(let value): handleLoadingCharactersState(value)
        case .loadingNextPage(let value): handleLoadingNextPageState(value)
        case .serviceError(let error): handleServiceError(error)
        }
    }
    
    func charactersListDidUpdate() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    // MARK: - State Handlers
    
    private func handleLoadingCharactersState(_ state: Bool) {
        state ? view.startLoading() : view.stopLoading()
    }
    
    private func handleLoadingNextPageState(_ state: Bool) { // @TODO: Maybe change this...
        let lastRowIndex = logicController.numberOfCharacters - 1
        DispatchQueue.main.async {
            let lastCell = self.tableView.cellForRow(at: IndexPath(row: lastRowIndex, section: 0))
            state ? lastCell?.startLoading() : lastCell?.stopLoading()
        }
    }
    
    private func handleServiceError(_ error: ServiceError) {
        AlertHelper.showAlert(inController: self, title: "Service Error!", message: error.localizedDescription)
    }
    
}
