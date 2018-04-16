//
//  BinaryInteger+Additions.swift
//  TapAdditionsKit
//
//  Copyright © 2018 Tap Payments. All rights reserved.
//

/// Useful Integer extension.
public extension BinaryInteger {
    
    // MARK: - Public -
    // MARK: Properties
    
    /// Returns string value of the receiver.
    public var stringValue: String {
     
        return "\(self)"
    }
}

/// Dummy struct to import SwiftStandartLibrary/BinaryInteger module.
public struct BinaryIntegerAdditions {
    
    @available (*, unavailable) private init() {
        
        fatalError("\(self) cannot be initialized.")
    }
}
