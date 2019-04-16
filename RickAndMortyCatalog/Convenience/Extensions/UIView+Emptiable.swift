//
//  UView+Emptiable.swift
//  RickAndMortyCatalog
//
//  Created by Andre Sanches Bocato on 16/04/19.
//  Copyright © 2019 Andre Sanches Bocato. All rights reserved.
//

import UIKit

protocol EmptiableView { }

extension UIView: EmptiableView {
    
    // MARK: - Functions
    
    func showEmptyView(message: String) {
        let emptyViewLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        emptyViewLabel.text = message
        emptyViewLabel.textColor = .gray
        emptyViewLabel.numberOfLines = 1
        emptyViewLabel.textAlignment = .center
        emptyViewLabel.sizeToFit()
        emptyViewLabel.tag = 222
        
        DispatchQueue.main.async {
            self.addSubview(emptyViewLabel)
        }
    }
    
    func hideEmptyView() {
        DispatchQueue.main.async {
            self.viewWithTag(222)?.removeFromSuperview()
        }
    }
    
}
