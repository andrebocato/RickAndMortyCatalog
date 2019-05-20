//
//  SettingsViewController.swift
//  RickAndMortyCatalog
//
//  Created by Andre Sanches Bocato on 09/04/19.
//  Copyright © 2019 Andre Sanches Bocato. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    // MARK: - Private Properties
    
    private let githubRepoURL = "https://github.com/andrebocato/RickAndMortyCatalog"
    private let apiDocumentationURL = "https://rickandmortyapi.com/documentation/"
    
    // @TODO: remove
    let settings = [
        ["delete all favorites"],
        ["switch to dark mode"],
        ["source code (github)", "api documentation"]
    ]
    
    // MARK: - IBOutlets
    
    @IBOutlet private weak var tableView: UITableView! {
        didSet {
            tableView.dataSource = self
            tableView.delegate = self
        }
    }
    
    @IBOutlet private weak var clearFavoritesButton: UIButton!
    @IBOutlet private weak var switchThemeFixedLabel: UILabel!
    
    // MARK: - Dependencies

    private let logicController: SettingsLogicController
    
    // MARK: - Initialization
    init(nibName nibNameOrNil: String?,
         bundle nibBundleOrNil: Bundle?,
         logicController: SettingsLogicController) {
        self.logicController = logicController
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.toolbar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.toolbar.isHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerTableViewCells()
    }
    
    // MARK: - UI Setup
    
    private func registerTableViewCells() {
        let bundle = Bundle(for: SettingsViewController.self)
        
        tableView.register(UINib(nibName: DestructiveCell.className, bundle: bundle),
                           forCellReuseIdentifier: DestructiveCell.className)
        
        tableView.register(UINib(nibName: SwitchCell.className, bundle: bundle),
                           forCellReuseIdentifier: SwitchCell.className)
        
        tableView.register(UINib(nibName: ExternalLinkCell.className, bundle: bundle),
                           forCellReuseIdentifier: ExternalLinkCell.className)

    }

}

// MARK: - Extensions

extension SettingsViewController: UITableViewDataSource {
    
    // MARK: - Table View Data Source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return settings.count // TODO: change
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settings[section].count // @TODO: change
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellType = SettingsCellType(section: indexPath.section, row: indexPath.row)
        
        switch cellType {
        case .deleteAll?:
            return tableView.dequeueReusableCell(ofClass: DestructiveCell.self, for: indexPath).configured(as: .deleteAll)
            
        case .switch?:
            let switchCell = tableView.dequeueReusableCell(ofClass: SwitchCell.self, for: indexPath)
            switchCell.configure(onSwitchValueChanged: { [weak self] (isOn) in
                self?.logicController.toggleDarkTheme(isOn)
            })
            return switchCell
            
        case .githubRepo?:
            return tableView.dequeueReusableCell(ofClass: ExternalLinkCell.self, for: indexPath).configured(as: .githubRepo)
            
        case .apiDocumentation?:
            return tableView.dequeueReusableCell(ofClass: ExternalLinkCell.self, for: indexPath).configured(as: .apiDocumentation)
            
        case .none:
            return UITableViewCell()
        }
        
    }
    
}

extension SettingsViewController: UITableViewDelegate {
    
    // MARK: - Table View Delegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let cellType = SettingsCellType(section: indexPath.section, row: indexPath.row)
        
        switch cellType {
        case .githubRepo?:
            presentAlert(title: "Leaving the app",
                         message: "You are being sent to an external page on the web. Do you wish to proceed?",
                         rightAction: UIAlertAction(title: "Go!", style: .default, handler: { [weak self] (action) in
                            guard let url = self?.githubRepoURL else { return }
                            self?.logicController.open(urlString: url)
                         }))
            
        case .apiDocumentation?:
            presentAlert(title: "Leaving the app",
                         message: "You are being sent to an external page on the web. Do you wish to proceed?",
                         rightAction: UIAlertAction(title: "Go!", style: .default, handler: { [weak self] (action) in
                            guard let url = self?.apiDocumentationURL else { return }
                            self?.logicController.open(urlString: url)
                         }))
            
        case .deleteAll?:
            presentAlert(title: "Deleting favorites",
                         message: "Are you sure you want to delete all your favorited characters? This action can't be undone.",
                         rightAction: UIAlertAction(title: "Delete", style: .destructive, handler: nil)) { [weak self] in
                            self?.logicController.deleteAllFavorites { [weak self] (result) in
                                switch result {
                                case .failure(let error):
                                    self?.presentAlert(title: "Error!", message: error.localizedDescription)
                                default: return
                                }
                            }
            }
            
        case .switch?: return
        case .none: return
        }
        
    }
}



