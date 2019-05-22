//
//  FavoritesViewController.swift
//  RickAndMortyCatalog
//
//  Created by Andre Sanches Bocato on 09/04/19.
//  Copyright © 2019 Andre Sanches Bocato. All rights reserved.
//

import UIKit
import RealmSwift

class FavoritesViewController: UIViewController, ThemeObserving {
    
    // MARK: - IBOutlets
    
    @IBOutlet private weak var collectionView: UICollectionView! {
        didSet {
            collectionView.dataSource = self
            collectionView.delegate = self
        }
    }
    
    // MARK: - Dependencies
    
    private var logicController: FavoritesLogicController
    private let viewControllersFactory: ViewControllersFactoryProtocol
    
    // MARK: - Initialization
    
    init(nibName nibNameOrNil: String?,
         bundle nibBundleOrNil: Bundle?,
         logicController: FavoritesLogicController,
         viewControllersFactory: ViewControllersFactoryProtocol) {
        self.logicController = logicController
        self.viewControllersFactory = viewControllersFactory
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let minimumSpacing: CGFloat = 1
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCollectionViewCells()
        addThemeObserver()
        loadCurrentTheme()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        logicController.loadFavorites()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        removeThemeObserver()
    }
    
    // MARK: - UI
    
    private func registerCollectionViewCells() {
        let bundle = Bundle(for: FavoriteCell.self)
        let className = FavoriteCell.className
        let cellNib = UINib(nibName: className, bundle: bundle)
        collectionView.register(cellNib, forCellWithReuseIdentifier: className)
    }
    
}

// MARK: - Extensions

extension FavoritesViewController: UICollectionViewDataSource {
    
    // MARK: - Collection View Data Source
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if logicController.numberOfFavorites == 0 {
            view.showEmptyView(message: "You have no favorites.")
        }
        return logicController.numberOfFavorites
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FavoriteCell.className, for: indexPath) as? FavoriteCell else { return UICollectionViewCell() }
        let modelController = logicController.modelController(for: indexPath.item)
        cell.configure(with: modelController)
        return cell
    }
    
}

extension FavoritesViewController: UICollectionViewDelegate {
    
    // MARK: - Collection View Delegate
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        collectionView.deselectItem(at: indexPath, animated: true)
        
        let selectedCharacterModelController = logicController.modelController(for: indexPath.row)
        let detailController = viewControllersFactory.createDetailsViewController(characterModelController: selectedCharacterModelController)
        navigationController?.pushViewController(detailController, animated: true)
    
    }
}

extension FavoritesViewController: UICollectionViewDelegateFlowLayout {
    
    // MARK: - Collection View Delegate Flow Layout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = (collectionView.bounds.width/3) - minimumSpacing
        return CGSize(width: size, height: size)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return minimumSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return minimumSpacing
    }
    
}

extension FavoritesViewController: FavoritesLogicControllerDelegate {
    
    func favoritesListDidUpdate() {
        DispatchQueue.main.async {
            self.view.hideEmptyView()
            self.collectionView.reloadData()
        }
    }
    
    func databaseFetchDidFailWithError(_ error: Error) {
        view.showEmptyView(message: "Could not fetch favorites. \n=(")
    }
    
}

extension FavoritesViewController: Themeable {
    
    func apply(theme: ThemeType) {
        view.backgroundColor = theme.viewBackgroundColor
        collectionView.backgroundColor = theme.viewBackgroundColor
        view.setNeedsDisplay()
        
        // @TODO: move outta here?
        tabBarController?.tabBar.unselectedItemTintColor = theme.unselectedButtonColor
        tabBarController?.tabBar.tintColor = theme.selectedButtonColor
        tabBarController?.tabBar.barTintColor = theme.tabBarColor
        navigationController?.navigationBar.barTintColor = theme.tabBarColor
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: theme.titleTextColor]
    }
    
}
