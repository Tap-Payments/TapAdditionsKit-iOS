//
//  UInt8+Additions.swift
//  TapAdditionsKit
//
//  Copyright © 2018 Tap Payments. All rights reserved.
//

/// Useful extension to UInt8.
public extension UInt8 {
    
    // MARK: - Public -
    // MARK: Properties
    
    /// Returns char string of the receiver.
    public var charString: String {
        
        return String(format: "%c", self)
    }
}

/// Dummy struct to import SwiftStandartLibrary/UInt8 module.
public struct UInt8Additions {
    
    @available (*, unavailable) private init() {
        
        fatalError("\(self) cannot be initialized.")
    }
}
