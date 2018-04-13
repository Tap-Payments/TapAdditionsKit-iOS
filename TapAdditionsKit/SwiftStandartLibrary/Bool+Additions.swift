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
