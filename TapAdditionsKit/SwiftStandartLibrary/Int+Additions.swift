//
//  Int+Additions.swift
//  TapAdditionsKit
//
//  Copyright © 2018 Tap Payments. All rights reserved.
//

/// Useful extension to Int.
public extension Int {
    
    // MARK: - Public -
    // MARK: Methods
    
    /// Basically converts Int to String.Index type.
    ///
    /// - Parameter string: String.
    /// - Returns: String.Index representation of Int.
    public func index(in string: String) -> String.Index {
        
        return string.index(string.startIndex, offsetBy: self)
    }
}

/// Dummy struct to import SwiftStandartLibrary/Int module.
public struct IntAdditions {
    
    @available (*, unavailable) private init() {
        
        fatalError("\(self) cannot be initialized.")
    }
}
