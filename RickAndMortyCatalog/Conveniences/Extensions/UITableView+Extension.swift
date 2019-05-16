//
//  UITableView+Extension.swift
//  RickAndMortyCatalog
//
//  Created by Andre Sanches Bocato on 16/05/19.
//  Copyright © 2019 Andre Sanches Bocato. All rights reserved.
//

import UIKit

extension UITableView {
    
    /// Dequeues reusable UITableViewCell using class name.
    ///
    /// - Parameter class: UITableViewCell type.
    /// - Returns: UITableViewCell object with associated class name.
    public func dequeueReusableCell<T: UITableViewCell>(ofClass class: T.Type) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: T.className) as? T else {
            fatalError("Couldn't find UITableViewCell of class \(T.className)")
        }
        return cell
    }
    
    /// Dequeues reusable UITableViewCell using class name for indexPath.
    ///
    /// - Parameters:
    ///   - class: UITableViewCell type.
    ///   - indexPath: Cell location in tableView.
    /// - Returns: UITableViewCell object with associated class name.
    public func dequeueReusableCell<T: UITableViewCell>(ofClass class: T.Type, for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: T.className, for: indexPath) as? T else {
            fatalError("Couldn't find UITableViewCell of class \(T.className)")
        }
        return cell
    }
    
    /// Registers UITableViewCell using class name.
    ///
    /// - Parameter class: UITableViewCell type.
    public func register<T: UITableViewCell>(cellOfClass class: T.Type) {
        register(T.self, forCellReuseIdentifier: T.className)
    }
    
}
