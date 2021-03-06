//
//  SettingsViewController.swift
//  RickAndMortyCatalog
//
//  Created by Andre Sanches Bocato on 09/04/19.
//  Copyright © 2019 Andre Sanches Bocato. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController, ThemeObserving {
    
    // MARK: - IBOutlets
    
    @IBOutlet private weak var tableView: UITableView! {
        didSet {
            tableView.dataSource = self
            tableView.delegate = self
        }
    }
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerTableViewCells()
        loadCurrentTheme()
        addThemeObserver()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.toolbar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        removeThemeObserver()
        navigationController?.toolbar.isHidden = false
    }
    
    // MARK: - UI Configuration
    
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

// MARK: - Table View Data Source

extension SettingsViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return logicController.settings.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return logicController.settings[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellType = SettingsCellType(section: indexPath.section, row: indexPath.row)
        
        switch cellType {
        case .deleteAll?:
            return tableView
                .dequeueReusableCell(ofClass: DestructiveCell.self, for: indexPath)
                .configured(as: .deleteAll)
            
        case .switch?:
            let switchCell = tableView.dequeueReusableCell(ofClass: SwitchCell.self, for: indexPath)
            
            switchCell.configure(isSwitchOn: logicController.isDarkThemeOn, onSwitchValueChanged: { [weak self] (isOn) in
                self?.logicController.toggleDarkTheme(isOn)
            })
            return switchCell
            
        case .githubRepo?:
            return tableView
                .dequeueReusableCell(ofClass: ExternalLinkCell.self, for: indexPath)
                .configured(as: .githubRepo)
            
        case .apiDocumentation?:
            return tableView
                .dequeueReusableCell(ofClass: ExternalLinkCell.self, for: indexPath)
                .configured(as: .apiDocumentation)
            
        case .none:
            return UITableViewCell()
        }
    }
    
}

// MARK: - Table View Delegate

extension SettingsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let cellType = SettingsCellType(section: indexPath.section, row: indexPath.row)
        switch cellType {
        case .githubRepo?:
            handleGithubRepoSelection()
            
        case .apiDocumentation?:
            handleAPIDocumentationSelection()
            
        case .deleteAll?:
            handleDeleteAllSelection()
            
        default:
            return
        }
    }
    
    // MARK: - Handlers
    
    private func handleGithubRepoSelection() {
        presentAlert(title: "Leaving the app",
                     message: "You are being sent to an external page on the web. Do you wish to proceed?",
                     rightAction: UIAlertAction(title: "Go!", style: .default, handler: { [weak self] _ in
                        self?.logicController.openGithubRepo(onError: { error in
                            self?.presentOkAlert(title: "Error!", message: error.localizedDescription)
                        })
                     }))
    }
    
    private func handleAPIDocumentationSelection() {
        presentAlert(title: "Leaving the app",
                     message: "You are being sent to an external page on the web. Do you wish to proceed?",
                     rightAction: UIAlertAction(title: "Go!", style: .default, handler: { [weak self] _ in
                        self?.logicController.openAPIDocumentation(onError: { error in
                            self?.presentOkAlert(title: "Error!", message: error.localizedDescription)
                        })
                     }))
        
    }
    
    private func handleDeleteAllSelection() {
        presentAlert(title: "Deleting favorites",
                     message: "Are you sure you want to delete all your favorited characters? This action can't be undone.",
                     rightAction: UIAlertAction(title: "Delete", style: .destructive, handler: nil)) { [weak self] in 
                        self?.logicController.deleteAllFavorites { [weak self] (result) in
                            switch result {
                            case .failure(let error):
                                self?.presentOkAlert(title: "Error!", message: error.localizedDescription)
                                
                            default:
                                return
                            }
                        }
        }
    }
    
}

// MARK: - Themeable

extension SettingsViewController: Themeable {
    
    func apply(_ theme: ThemeType) {
        tableView.backgroundColor = theme.viewBackgroundColor
        view.backgroundColor = theme.viewBackgroundColor
        view.setNeedsDisplay()
        
        tabBarController?.tabBar.apply(theme)
        navigationController?.navigationBar.apply(theme)
    }
 
}
