//
//  RMLabel.swift
//  RickAndMortyCatalog
//
//  Created by Andre Sanches Bocato on 21/05/19.
//  Copyright © 2019 Andre Sanches Bocato. All rights reserved.
//

import UIKit

@IBDesignable
class RMLabel: UILabel {
    
    // MARK: - Initialization
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        sharedInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        sharedInit()
    }
    
    // MARK: - Lifecycle
    
    override func prepareForInterfaceBuilder() {
        sharedInit()
    }
    
    // MARK: - Functions
    
    func sharedInit() {
        
    }
    
}
