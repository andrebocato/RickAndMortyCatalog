//
//  RMCharacterImageFetcherProtocol.swift
//  RickAndMortyCatalog
//
//  Created by Eduardo Sanches Bocato on 27/04/19.
//  Copyright © 2019 Andre Sanches Bocato. All rights reserved.
//

import Foundation

protocol RMCharacterImageFetcherProtocol {
    
    /// Fetches an RMCharacter image
    ///
    /// - Parameter completion: the data
    func fetchImageData(completion: @escaping (Data) -> Void)
    
    /// Cancels the network request for image data.
    func cancelImageRequest()
}
