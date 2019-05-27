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
    
    @IBOutlet private weak var favoritesCollectionView: UICollectionView! {
        didSet {
            favoritesCollectionView.dataSource = self
            favoritesCollectionView.delegate = self
        }
    }
    @IBOutlet private weak var segmentedCollectionView: UICollectionView! {
        didSet {
            segmentedCollectionView.dataSource = self
            segmentedCollectionView.delegate = self
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
    
    // MARK: - Private Properties
    
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
        let bundle = Bundle(for: FavoritesViewController.self)
        
        segmentedCollectionView.register(UINib(nibName: FilterCell.className, bundle: bundle),
                                         forCellWithReuseIdentifier: FilterCell.className)
        
        favoritesCollectionView.register(UINib(nibName: FavoriteCell.className, bundle: bundle),
                                         forCellWithReuseIdentifier: FavoriteCell.className)
    }
    
}

// MARK: - Extensions

extension FavoritesViewController: UICollectionViewDataSource {
    
    // MARK: - Collection View Data Source
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case segmentedCollectionView:
            return Filters.allCases.count
            
        case favoritesCollectionView:
            if logicController.numberOfFavorites == 0 {
                view.showEmptyView(message: "You have no favorites.")
            }
            return logicController.numberOfFavorites
            
        default: return 0
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case segmentedCollectionView: 
            guard let title = Filters(rawValue: indexPath.item)?.stringValue else { return UICollectionViewCell() }
            return collectionView.dequeueReusableCell(ofClass: FilterCell.self, for: indexPath).configured(withTitle: title)
            
        case favoritesCollectionView:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FavoriteCell.className, for: indexPath) as? FavoriteCell else { return UICollectionViewCell() }
            let modelController = logicController.modelController(for: indexPath.item)
            cell.configure(with: modelController)
            return cell
            
        default: return UICollectionViewCell()
        }
    }
    
}

extension FavoritesViewController: UICollectionViewDelegate {
    
    // MARK: - Collection View Delegate
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch collectionView {
        case segmentedCollectionView:
            collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
            logicController.filterCharacters(by: indexPath.item)
            // @TODO: filter
            
        case favoritesCollectionView:
            collectionView.deselectItem(at: indexPath, animated: true)
            let selectedCharacterModelController = logicController.modelController(for: indexPath.row)
            let detailController = viewControllersFactory.createDetailsViewController(characterModelController: selectedCharacterModelController)
            navigationController?.pushViewController(detailController, animated: true)
            
        default: return
        }
    }
}

extension FavoritesViewController: UICollectionViewDelegateFlowLayout {
    
    // MARK: - Collection View Delegate Flow Layout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch collectionView {
        case segmentedCollectionView:
            let size = (collectionView.bounds.width/2) - minimumSpacing
            return CGSize(width: size, height: size)
            
        case favoritesCollectionView:
            let size = (collectionView.bounds.width/3) - minimumSpacing
            return CGSize(width: size, height: size)
            
        default: return CGSize(width: 0.0, height: 0.0)
        }
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
            self.favoritesCollectionView.reloadData()
        }
    }
    
    func databaseFetchDidFailWithError(_ error: Error) {
        view.showEmptyView(message: "Could not fetch favorites. \n=(")
    }
    
}

extension FavoritesViewController: Themeable {
    
    func apply(_ theme: ThemeType) {
        view.backgroundColor = theme.viewBackgroundColor
        segmentedCollectionView.backgroundColor = theme.viewBackgroundColor
        favoritesCollectionView.backgroundColor = theme.viewBackgroundColor
        view.setNeedsDisplay()
        
        tabBarController?.tabBar.apply(theme)
        navigationController?.navigationBar.apply(theme)
    }
    
}
