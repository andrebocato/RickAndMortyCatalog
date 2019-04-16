//
//  UIView+Extension.swift
//  RickAndMortyCatalog
//
//  Created by Andre Sanches Bocato on 16/04/19.
//  Copyright © 2019 Andre Sanches Bocato. All rights reserved.
//

import UIKit

protocol LoadableView { }

extension LoadableView where Self: UIView {
    
    // MARK: - Functions
    
    func startLoading() {
        let loadingView = UIView(frame: self.bounds)
        loadingView.backgroundColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        loadingView.tag = 111
        
        let activityIndicator = UIActivityIndicatorView(style: .whiteLarge)
        activityIndicator.startAnimating()
        activityIndicator.center = loadingView.center
        
        DispatchQueue.main.async {
            self.isUserInteractionEnabled = false
            loadingView.addSubview(activityIndicator)
            self.addSubview(loadingView)
        }
    }
    
    func stopLoading() {
        DispatchQueue.main.async {
            self.viewWithTag(111)?.removeFromSuperview()
            self.isUserInteractionEnabled = true
        }
    }
}
