//
//  AlertPresenting.swift
//  RickAndMortyCatalog
//
//  Created by Andre Sanches Bocato on 09/04/19.
//  Copyright © 2019 Andre Sanches Bocato. All rights reserved.
//

import UIKit

// MARK: - Protocol

protocol AlertPresenting {
    /// Presents an Alert Controller with cancel and destructive actions.
    ///
    /// - Parameters:
    ///   - title: Title to be displayed in the alert.
    ///   - message: Optional message to be displayed in the alert.
    ///   - rightAction: Main action of the alert.
    ///   - completionHandler: Closure to be executed right after presenting the alert.
    func presentAlert(title: String, message: String?, rightAction: UIAlertAction, completionHandler: (() -> Void)?)
    /// Presents an Alert Controller with an alert message.
    ///
    /// - Parameters:
    ///   - title: Title to be displayed in the alert ("Ok" by default).
    ///   - message: Optional message to be displayed in the alert.
    ///   - completionHandler: Closure to be executed right after presenting the alert.
    func presentOkAlert(title: String?, message: String?, completionHandler: (() -> Void)?)
}

extension UIViewController: AlertPresenting { }

extension AlertPresenting where Self: UIViewController {
    
    // MARK: - Protocol Functions
    
    func presentAlert(title: String,
                      message: String?,
                      rightAction: UIAlertAction,
                      completionHandler: (() -> Void)? = nil) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: { _ in
            alert.dismiss(animated: true, completion: nil)
        })
        
        alert.addAction(cancelAction)
        alert.addAction(rightAction)
        
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: completionHandler)
        }
        
    }
    
    func presentOkAlert(title: String?,
                        message: String?,
                        completionHandler: (() -> Void)? = nil) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: title ?? "Ok", style: .cancel, handler: { _ in
            alert.dismiss(animated: true, completion: nil)
        })
        alert.addAction(okAction)
        
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: completionHandler)
        }
    }
    
}
