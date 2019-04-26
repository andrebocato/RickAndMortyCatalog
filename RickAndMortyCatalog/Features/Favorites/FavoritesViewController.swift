//
//  FavoritesViewController.swift
//  RickAndMortyCatalog
//
//  Created by Andre Sanches Bocato on 09/04/19.
//  Copyright © 2019 Andre Sanches Bocato. All rights reserved.
//

import UIKit
import RealmSwift

class FavoritesViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet private weak var collectionView: UICollectionView! {
        didSet {
            collectionView.dataSource = self
            collectionView.delegate = self
        }
    }
    
    // MARK: - Dependencies
    
    private let service: RMCharactersServiceProtocol
    
    // MARK: - Initialization
    
    init(nibName nibNameOrNil: String?,
         bundle nibBundleOrNil: Bundle?,
         service: RMCharactersServiceProtocol) {
        self.service = service
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - IBActions
    
    // MARK: - Properties
    
    var favoritedCharacters = [RMCharacter]() {
        didSet {
            collectionView.reloadData() 
        }
    }
    
    private let minimumSpacing: CGFloat = 1
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCollectionViewCells()
        loadFavorites()
    }
    
    // MARK: - UI
    
    private func registerCollectionViewCells() {
        let bundle = Bundle(for: FavoriteCell.self)
        let className = FavoriteCell.className
        let cellNib = UINib(nibName: className, bundle: bundle)
        collectionView.register(cellNib, forCellWithReuseIdentifier: className)
    }
    
    // MARK: - Functions
    
    private func loadFavorites() {
        let realm = try! Realm()
        let database = FavoritesDatabase(realm: realm)
        favoritedCharacters = try! database.fetchAllFavorites().map { $0.rmCharacter }
    }
    
    // MARK: - Configuration Functions
    
    // MARK: - Helper Functions
    
}

// MARK: - Extensions

extension FavoritesViewController: UICollectionViewDataSource {
    
    // MARK: - Collection View Data Source
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard favoritedCharacters.count > 0 else {
            collectionView.showEmptyView(message: "You have no favorites.")
            return 0
        }
        return favoritedCharacters.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FavoriteCell.className, for: indexPath) as? FavoriteCell else { return UICollectionViewCell() }
        cell.configure(with: favoritedCharacters[indexPath.item]) 
        return cell
    }
    
}

extension FavoritesViewController: UICollectionViewDelegate {
    
    // MARK: - Collection View Delegate
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        collectionView.deselectItem(at: indexPath, animated: true)
        
//        let selectedCharacter = favoritedCharacters[indexPath.item]
//
//        let detailsController = CharacterDetailViewController(nibName: CharacterDetailViewController.className,
//                                                              bundle: Bundle(for: CharacterDetailViewController.self),
//                                                              service: DependencyInjection.charactersService,
//                                                              favoritesDatabase: DependencyInjection.favoritesDatabase,
//                                                              character: selectedCharacter)
//        navigationController?.pushViewController(detailsController, animated: true)
    
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
