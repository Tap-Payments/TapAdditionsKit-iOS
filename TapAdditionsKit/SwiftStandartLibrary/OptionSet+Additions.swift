//
//  OptionSet+Additions.swift
//  TapAdditionsKit
//
//  Copyright © 2018 Tap Payments. All rights reserved.
//

/// Useful extension to OptionSet protocol.
public extension OptionSet {
    
    /// No options ( e.g. [] ).
    public static var none: Self { return [] }
}

/// Dummy struct to import SwiftStandartLibrary/OptionSet module.
public struct OptionSetAdditions {
    
    @available (*, unavailable) private init() {
        
        fatalError("\(self) cannot be initialized.")
    }
}
