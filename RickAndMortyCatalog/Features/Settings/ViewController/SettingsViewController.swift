//
//  SettingsViewController.swift
//  RickAndMortyCatalog
//
//  Created by Andre Sanches Bocato on 09/04/19.
//  Copyright © 2019 Andre Sanches Bocato. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    // MARK: - Properties
    
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
        
    }
    
    // MARK: - IBActions
    
    // @TODO: move to cell file
    private func deleteAllFavoritesButtonDidReceiveTouchUpInside(_ sender: Any) {
        AlertHelper.presentAlert(inController: self,
                                 title: "Deleting favorites",
                                 message: "Are you sure you want to delete all your favorited characters? This action can't be undone.",
                                 rightAction: UIAlertAction(title: "Delete", style: .destructive, handler: nil)) { [weak self] in
                                    self?.logicController.deleteAllFavorites { [weak self] (result) in
                                        switch result {
                                        case .failure(let error):
                                            AlertHelper.presentAlert(inController: self, title: "Error!", message: error.localizedDescription)
                                        default: return
                                        }
                                    }
        }
    }

}

// MARK: - Extensions

enum SettingsCellType {
    
    case deleteAll
    case `switch`
    case githubRepo
    case apiDocumentation
    
    init?(section: Int, row: Int) {
        switch (section, row) {
        case (0, 0): self = .deleteAll
        case (1, 0): self = .switch
        case (2, 0): self = .githubRepo
        case (2, 1): self = .apiDocumentation
        default: return nil
        }
    }
    
}

extension SettingsViewController: UITableViewDataSource {
    
    // MARK: - Table View Data Source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return settings.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settings[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        if let cellType = SettingsCellType(section: indexPath.section, row: indexPath.row) {
        switch cellType {
        case .deleteAll:
            if let destructiveCell = tableView.dequeueReusableCell(withIdentifier: DestructiveCell.className) as? DestructiveCell {
                cell = destructiveCell.configured(as: .deleteAll)
            }
        case .githubRepo:
            if let externalLinkCell = tableView.dequeueReusableCell(withIdentifier: ExternalLinkCell.className) as? ExternalLinkCell {
                cell = externalLinkCell.configured(as: .githubRepo)
            }
        case .switch:
            if let switchCell = tableView.dequeueReusableCell(withIdentifier: SwitchCell.className) as? SwitchCell {
                switchCell.configure(onSwitchValueChanged: { [weak self] (isOn) in
                    self?.logicController.toggleDarkTheme(isOn)
                })
                cell = switchCell
            }
        case .apiDocumentation:
            if let externalLinkCell = tableView.dequeueReusableCell(withIdentifier: ExternalLinkCell.className) as? ExternalLinkCell {
                cell = externalLinkCell.configured(as: .apiDocumentation)
            }
        }
        return cell
    }
    
}

extension SettingsViewController: UITableViewDelegate {
    
    // MARK: - Table View Delegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
}
