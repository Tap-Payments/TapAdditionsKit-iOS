//
//  Bool+Additions.swift
//  TapAdditionsKit
//
//  Copyright © 2018 Tap Payments. All rights reserved.
//

/// Useful Bool extension.
extension Bool: ExpressibleByIntegerLiteral {
    
    public init(integerLiteral value: Int) {
        
        self.init(value != 0)
    }
}

/// Dummy struct to import SwiftStandartLibrary/Bool module.
public struct BoolAdditions {
    
    @available (*, unavailable) private init() {
        
        fatalError("\(self) cannot be initialized.")
    }
}
