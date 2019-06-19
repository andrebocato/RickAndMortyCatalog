//
//  CharactersViewController.swift
//  RickAndMortyCatalog
//
//  Created by Andre Sanches Bocato on 09/04/19.
//  Copyright © 2019 Andre Sanches Bocato. All rights reserved.
//

import Foundation
import UIKit

class CharactersViewController: UIViewController, ThemeObserving {
    
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
    @IBOutlet private weak var longPressGestureRecognizer: UILongPressGestureRecognizer!
    
    // MARK: - Private Properties

    private let cellHeight: CGFloat = 80
    
    // MARK: - IBActions
    
    // disabled. not working
    @IBAction private func longPressGestureRecognizerDidReceiveActionEvent(_ sender: UILongPressGestureRecognizer) {
        switch sender.state {
        case .began:
            toggleFavoriteForLongPressGesture(sender)
            
        default:
            return
        }
    }
        
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
        loadCurrentTheme()
        addThemeObserver()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        removeThemeObserver()
    }
    
    // MARK: - UI Setup
    
    private func registerTableViewCells() {
        let bundle = Bundle(for: CharacterCell.self)
        let className = CharacterCell.className
        let cellNib = UINib(nibName: className, bundle: bundle)
        tableView.register(cellNib, forCellReuseIdentifier: className)
    }
    
    private func toggleFavoriteForLongPressGesture(_ longPressGestureRecognizer: UILongPressGestureRecognizer) {
        let touchPoint = longPressGestureRecognizer.location(in: tableView)
        guard let indexPath = tableView.indexPathForRow(at: touchPoint) else { return }
        let modelController = logicController.modelController(for: indexPath.row)
        logicController.toggleFavorite(modelController)
    }
}

// MARK: - Table View Data Source

extension CharactersViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return logicController.numberOfCharacters
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(ofClass: CharacterCell.self, for: indexPath)
        let modelController = logicController.modelController(for: indexPath.row)
        
        cell.configure(with: modelController, onFavoriteErrorCallBack: { [weak self] (error) in
            self?.presentOkAlert(title: "Persistence Error!", message: error.localizedDescription)
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

// MARK: - Table View Delegate

extension CharactersViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let selectedCharacterModelController = logicController.modelController(for: indexPath.row)
        let detailController = viewControllersFactory.createDetailsViewController(characterModelController: selectedCharacterModelController)
        
        navigationController?.pushViewController(detailController, animated: true)
    }
    
}

// MARK: - Characters Logic Controller Delegate

extension CharactersViewController: CharactersLogicControllerDelegate {
    
    func stateDidChange(_ newState: CharactersLogicControllerState) {
        switch newState {
        case .loadingCharacters(let value):
            handleLoadingCharactersState(value)
            
        case .loadingNextPage(let value):
            handleLoadingNextPageState(value)
            
        case .serviceError(let error):
            handleServiceError(error)
        }
    }
    
    func charactersListDidUpdate() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func favoriteStateChanged(_ isFavorite: Bool) {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    // MARK: - State Handlers
    
    private func handleLoadingCharactersState(_ state: Bool) {
        state ? view.startLoading() : view.stopLoading()
    }
    
     // @TODO: fix. not working
    private func handleLoadingNextPageState(_ state: Bool) {
        let lastRowIndex = logicController.numberOfCharacters - 1
        
        DispatchQueue.main.async {
            let lastCell = self.tableView.cellForRow(at: IndexPath(row: lastRowIndex, section: 0))
            state ? lastCell?.startLoading() : lastCell?.stopLoading()
        }
    }
    
    private func handleServiceError(_ error: ServiceError) {
        presentAlert(title: "Service Error!",
                     message: error.localizedDescription,
                     rightAction: UIAlertAction(title: "Retry", style: .default, handler: { [weak self] _ in
                        self?.logicController.loadCharacters()
                     }))
    }
    
}

// MARK: - Themeable

extension CharactersViewController: Themeable {
    
    func apply(_ theme: ThemeType) {
        tableView.backgroundColor = theme.viewBackgroundColor
        view.backgroundColor = theme.viewBackgroundColor
        view.setNeedsDisplay()
        
        tabBarController?.tabBar.apply(theme)
        navigationController?.navigationBar.apply(theme)
    }
    
}
