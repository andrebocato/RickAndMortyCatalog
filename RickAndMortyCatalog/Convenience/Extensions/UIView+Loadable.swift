//
//  UIView+Loadable.swift
//  RickAndMortyCatalog
//
//  Created by Andre Sanches Bocato on 16/04/19.
//  Copyright © 2019 Andre Sanches Bocato. All rights reserved.
//

import UIKit

protocol LoadableView { }

fileprivate let loadingViewTag = 111

extension UIView: LoadableView {
        
    // MARK: - Functions
    
    /// Presents a subview with a light gray background and an activity indicator in the middle.
    func startLoading() {
        let loadingView = UIView(frame: self.bounds)
        loadingView.backgroundColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        loadingView.tag = loadingViewTag
        
        let activityIndicator = UIActivityIndicatorView(style: .whiteLarge)
        activityIndicator.startAnimating()
        activityIndicator.center = loadingView.center
        
        DispatchQueue.main.async {
            self.isUserInteractionEnabled = false
            loadingView.addSubview(activityIndicator)
            self.addSubview(loadingView)
        }
    }
    
    /// Removes the loading subview previously added.
    func stopLoading() {
        DispatchQueue.main.async {
            self.viewWithTag(loadingViewTag)?.removeFromSuperview()
            self.isUserInteractionEnabled = true
        }
    }
}
