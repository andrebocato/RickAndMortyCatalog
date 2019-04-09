//
//  AlertHelper.swift
//  RickAndMortyCatalog
//
//  Created by Andre Sanches Bocato on 09/04/19.
//  Copyright © 2019 Andre Sanches Bocato. All rights reserved.
//

import UIKit

class AlertHelper {
    
    // MARK: - Initialization
    
    private init() {}
    
    // MARK: - Functions
    
    /// Presents a custom alert with an action by default and an optional right action.
    ///
    /// - Parameters:
    ///   - controller: UIViewController where the alert is being presented.
    ///   - title: Title to be displayed in the alert.
    ///   - message: Message to be displayed in the alert.
    ///   - style: Style of the default action.
    ///   - rightAction: Optional right action.
    ///   - completionHandler: Closure executed right after the view is dismissed.
    static func showAlert(inController controller: UIViewController?,
                          title: String,
                          message: String?,
                          style: UIAlertAction.Style,
                          rightAction: UIAlertAction? = nil,
                          completionHandler: (() -> Void)? = nil) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: style, handler: { (action) in
            if rightAction == nil {
                alert.dismiss(animated: true, completion: nil)
            } else {
                completionHandler?()
            }
        })
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
        })
        
        alert.addAction(okAction)
        if let rightAction = rightAction {
            alert.addAction(rightAction)
        } else {
            alert.addAction(cancelAction)
        }
        
        DispatchQueue.main.async {
            controller?.present(alert, animated: true, completion: completionHandler)
        }
        
    }
}
