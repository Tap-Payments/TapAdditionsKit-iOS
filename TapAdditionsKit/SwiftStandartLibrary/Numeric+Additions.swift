//
//  Numeric+Additions.swift
//  TapAdditionsKit
//
//  Copyright © 2018 Tap Payments. All rights reserved.
//

public extension Numeric {
    
    /// Interpolates value between start and finish.
    ///
    /// - Parameters:
    ///   - start: Left bound.
    ///   - finish: Right bound.
    ///   - progress: Progress in range [0, 1]
    /// - Returns: Interpolated value.
    public static func interpolate<Type>(start: Type, finish: Type, progress: Type) -> Type where Type: Numeric {
        
        return start + (finish - start) * progress
    }
}

/// Dummy struct to import SwiftStandartLibrary/Numeric module.
public struct NumericAdditions {
    
    @available (*, unavailable) private init() {
        
        fatalError("\(self) cannot be initialized.")
    }
}
