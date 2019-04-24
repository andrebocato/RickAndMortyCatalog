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
    
    /// Presents a subview with an activity indicator in the middle.
    func startLoading() {
        let loadingView = UIView(frame: self.bounds)
        loadingView.backgroundColor = .white
        loadingView.tag = loadingViewTag
        loadingView.center = self.center // @TODO: fix that
        
        let activityIndicator = UIActivityIndicatorView(style: .whiteLarge)
        activityIndicator.startAnimating()
        activityIndicator.color = .black
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
