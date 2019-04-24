//
//  String+Encription.swift
//  RickAndMortyCatalog
//
//  Created by Andre Sanches Bocato on 24/04/19.
//  Copyright © 2019 Andre Sanches Bocato. All rights reserved.
//

import Foundation
import CommonCrypto

extension String {
    
    var md5: String? {
        guard let stringData = self.data(using: .utf8) else { return nil }
        
        var digest = [UInt8](repeating: 0, count: Int(CC_MD5_DIGEST_LENGTH))
        let stringPointer = [UInt8](stringData)
        CC_MD5(UnsafeRawPointer(stringPointer), CC_LONG(stringData.count), &digest)
        
        var output = ""
        
        for i in digest {
            let signedByte = Int8(bitPattern: i)
            output += "\(signedByte)"
        }
        
        return output
    }
    
}
