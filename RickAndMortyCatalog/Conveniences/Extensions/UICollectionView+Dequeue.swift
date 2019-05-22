//
//  UICollectionView+Dequeue.swift
//  RickAndMortyCatalog
//
//  Created by Andre Sanches Bocato on 22/05/19.
//  Copyright © 2019 Andre Sanches Bocato. All rights reserved.
//

import UIKit

extension UICollectionView {
    
    /// Dequeues reusable UICollectionViewCell using class name for indexPath.
    ///
    /// - Parameters:
    ///   - class: UICollectionViewCell type.
    ///   - indexPath: Cell location in collectionView.
    /// - Returns: UICollectionViewCell object with associated class name.
    public func dequeueReusableCell<T: UICollectionViewCell>(ofClass class: T.Type, for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withReuseIdentifier: `class`.className, for: indexPath) as? T else {
            fatalError("Couldn't find UICollectionViewCell of class \(`class`.className)")
        }
        return cell
    }
    
}
