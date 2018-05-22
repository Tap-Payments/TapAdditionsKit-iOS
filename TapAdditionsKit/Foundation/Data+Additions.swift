//
//  Data+Additions.swift
//  TapAdditionsKit
//
//  Copyright © 2018 Tap Payments. All rights reserved.
//

import func ObjectiveC.autoreleasepool
import struct Foundation.NSData.Data
import class UIKit.UIImage.UIImage
import func UIKit.UIImage.UIImagePNGRepresentation

/// Useful extension to Data struct.
public extension Data {
    
    // MARK: - Public -
    // MARK: Properties
    
    /// Returns hexademical string.
    public var hexString: String {
        
        return self.reduce(String.empty, {$0 + String(format: "%02X", $1)})
    }
    
    // MARK: Methods
    
    /*!
     Creates and returns data representation of UIImage
     
     - parameter image: Image to create data.
     
     - returns: Data
     */
    public static func dataWith(image: UIImage?) -> Data? {
        
        guard let transparentImage = image?.transparentImage else { return nil }
        
        var data: Data?
        
        return autoreleasepool {
            
            data = UIImagePNGRepresentation(transparentImage)
            return data
        }
    }
}

/// Dummy struct to import Foundation/Date module.
public struct DateAdditions {
    
    @available (*, unavailable) private init() {
        
        fatalError("\(self) cannot be initialized.")
    }
}
