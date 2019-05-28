//
//  DetailViewController.swift
//  RickAndMortyCatalog
//
//  Created by Andre Sanches Bocato on 09/04/19.
//  Copyright © 2019 Andre Sanches Bocato. All rights reserved.
//
// @TODO: set text as "-" when result is ""

import Foundation
import UIKit
import RealmSwift

class DetailViewController: UIViewController, ThemeObserving {
    
    // MARK: - Dependencies
    
    private var logicController: DetailLogicController
    
    // MARK: - IBOutlets
        
    @IBOutlet private var tableView: UITableView! {
        didSet {
            tableView.dataSource = self
        }
    }
    
    // MARK: - Initialization
    
    init(nibName nibNameOrNil: String?,
         bundle nibBundleOrNil: Bundle?,
         logicController: DetailLogicController) {
        self.logicController = logicController
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.logicController.delegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerTableViewCells()
        createBarButtonItem()
        loadCurrentTheme()
        addThemeObserver()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.toolbar.isHidden = true
        navigationController?.tabBarController?.tabBar.isHidden = true
        setupViewData()
        removeThemeObserver()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.toolbar.isHidden = false
        navigationController?.tabBarController?.tabBar.isHidden = false
    }
    
    // MARK: - UI
    
    private func registerTableViewCells() {
        let bundle = Bundle(for: DetailFieldCell.self)
        tableView.register(UINib(nibName: DetailFieldCell.className, bundle: bundle),
                           forCellReuseIdentifier: DetailFieldCell.className)
    }
    
    private func createBarButtonItem() {
        let barButtonItem = UIBarButtonItem(image: UIImage(named: "unfavorited"),
                                            style: .done,
                                            target: self,
                                            action: #selector(toggleFavoriteBarButtonItemDidReceiveTouchUpInside(_:)))
        
        navigationItem.rightBarButtonItem = barButtonItem
    }
    
    private func setupViewData() {
        updateBarButtonImage()
        setupImageView()
        view.setNeedsDisplay()
    }
    
    private func setupImageView() {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.width))
        let imageView = UIImageView(frame: headerView.frame)
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 8.0
        imageView.startLoading()
        
        headerView.addSubview(imageView)
        
        logicController.fetchImageData { [weak self] (imageData) in
            DispatchQueue.main.async {
                imageView.image = UIImage(data: imageData)
                imageView.stopLoading()
                self?.tableView.tableHeaderView = headerView
            }
        }
        
    }
    
    private func updateBarButtonImage() {
        guard let barButtonItem = navigationItem.rightBarButtonItem else { return }
        let buttonImageName = logicController.isFavoriteCharacter ? "favorited" : "unfavorited"
        barButtonItem.image = UIImage(named: buttonImageName)
    }
    
    // MARK: - Actions
    
    @objc private func toggleFavoriteBarButtonItemDidReceiveTouchUpInside(_ sender: UIBarButtonItem) {
        logicController.toggleFavorite()
    }
    
}

extension DetailViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DetailFields.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let fields = DetailFields(rawValue: indexPath.row) else { return UITableViewCell() }
        return tableView
            .dequeueReusableCell(ofClass: DetailFieldCell.self, for: indexPath)
            .configured(with: logicController.character, field: fields)
    }
    
}

extension DetailViewController: DetailLogicControllerDelegate {
    
    func favoriteStateChanged(_ isFavorite: Bool) {
        updateBarButtonImage()
    }
    
    func stateDidChange(_ newState: DetailLogicControllerState) {
        switch newState {
        case .error(let e): handleError(e)
        case .loadingImage(let value): handleLoadingImageState(value)
        }
    }
    
    // MARK: - State Handlers
    
    private func handleLoadingImageState(_ loading: Bool) {
//        loading ? imageView.startLoading() : imageView.stopLoading()
    }
    
    private func handleError(_ error: Error) {
        presentAlert(title: "Error!", message: error.localizedDescription) { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        }
    }
    
}

extension DetailViewController: Themeable {
    
    func apply(_ theme: ThemeType) {
        tableView.backgroundColor = theme.viewBackgroundColor
        view.backgroundColor = theme.viewBackgroundColor
        
        navigationController?.navigationBar.apply(theme)
    }
    
}
