//
//  URLOpenerProtocol.swift
//  RickAndMortyCatalog
//
//  Created by Andre Sanches Bocato on 17/05/19.
//  Copyright © 2019 Andre Sanches Bocato. All rights reserved.
//

import Foundation
import UIKit

protocol URLOpenerProtocol {
    func canOpenURL(_ url: URL) -> Bool
    func open(_ url: URL, options: [UIApplication.OpenExternalURLOptionsKey: Any], completionHandler completion: ((Bool) -> Void)?)
}

extension UIApplication: URLOpenerProtocol { }
