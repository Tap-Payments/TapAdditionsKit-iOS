//
//  MemoryLayout+Additions.swift
//  TapAdditionsKit
//
//  Copyright © 2018 Tap Payments. All rights reserved.
//

/// Useful additions to MemoryLayout.
public extension MemoryLayout {
    
    /// Memory size of a type.
    ///
    /// - Parameter _: Type.
    /// - Returns: memory size of a type.
    public static func sizeof<T>(_ : T.Type) -> Int {
        
        return MemoryLayout<T>.size
    }
    
    /// Memory size of an object.
    ///
    /// - Parameter _: Object.
    /// - Returns: Memory size of an object.
    public static func sizeof<T> (_ : T) -> Int {
        
        return MemoryLayout<T>.size
    }
    
    /// Memory size of an array.
    ///
    /// - Parameter value: Array.
    /// - Returns: Memory size of an array.
    public static func sizeof<T>(_ value: [T]) -> Int {
        
        return MemoryLayout<T>.size * value.count
    }
}

/// Dummy struct to import SwiftStandartLibrary/MemoryLayout module.
public struct MemoryLayoutAdditions {
    
    @available (*, unavailable) private init() {
        
        fatalError("\(self) cannot be initialized.")
    }
}
