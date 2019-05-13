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
    @IBOutlet private weak var themeSwitch: UISwitch!
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
        let bundle = Bundle(for: DestructiveCell.self)
        let className = DestructiveCell.className
        let cellNib = UINib(nibName: className, bundle: bundle)
        tableView.register(cellNib, forCellReuseIdentifier: className)
        
        // TODO: register other cells
    }
    
    // MARK: - IBActions
    
    // @TODO: move to cell file
    @IBAction private func deleteAllFavoritesButtonDidReceiveTouchUpInside(_ sender: Any) {
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
    
    // @TODO: move to cell file
    @IBAction func themeSwitchValueChanged(_ sender: Any) {
        if themeSwitch.isOn {
            debugPrint("dark theme enabled")
        } else {
            debugPrint("dark theme disabled")
        }
    }
    
}

// MARK: - Extensions

extension SettingsViewController: UITableViewDataSource {
    
    // MARK: - Table View Data Source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return settings.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settings[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch (indexPath.section, indexPath.row) {
        case (0, 0): return DestructiveCell().configured(as: .deleteAll)
        case (1, 0): return SwitchCell().configured(as: .darkTheme)
        case (2, 0): return ExternalLinkCell().configured(as: .githubRepo)
        case (2, 1): return ExternalLinkCell().configured(as: .apiDocumentation)
        default: return UITableViewCell()
        }
    }
    
}

extension SettingsViewController: UITableViewDelegate {
    
    // MARK: - Table View Delegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
}
