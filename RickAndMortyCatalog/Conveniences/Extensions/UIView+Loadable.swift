//
//  UIView+Loadable.swift
//  RickAndMortyCatalog
//
//  Created by Andre Sanches Bocato on 16/04/19.
//  Copyright © 2019 Andre Sanches Bocato. All rights reserved.
//

import UIKit

// MARK: - Protocols

protocol LoadableView { }

// MARK: - Tags

fileprivate let loadingViewTag = 111

//MARK: - Loadable View

extension UIView: LoadableView {
    
    /// Presents a subview with an activity indicator in the middle.
    ///
    /// - Parameter style: Style of the activity indicator, 'whiteLarge' by default...
    func startLoading(style: UIActivityIndicatorView.Style = .whiteLarge) {
        
        let loadingView = UIView(frame: frame)
        loadingView.backgroundColor = .white
        loadingView.tag = loadingViewTag
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        loadingView.center = center
        
        let activityIndicator = UIActivityIndicatorView(style: style)
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
