//
//  CountableClosedRange+Additions.swift
//  TapAdditionsKit
//
//  Copyright © 2018 Tap Payments. All rights reserved.
//

/// Useful addition for CountableClosedRange.
public extension CountableClosedRange where Bound == Int {
    
    // MARK: - Public -
    // MARK: Properties
    
    /// Returns random value of a range.
    public var randomValue: Bound {
        
        return Int(arc4random_uniform(UInt32(self.count) + 1)) + self.lowerBound
    }
}

/// Dummy struct to import SwiftStandartLibrary/CountableClosedRange module.
public struct CountableClosedRangeAdditions {
    
    @available (*, unavailable) private init() {
        
        fatalError("\(self) cannot be initialized.")
    }
}
