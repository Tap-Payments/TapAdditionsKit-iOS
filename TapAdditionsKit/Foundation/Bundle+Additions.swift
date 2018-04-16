//
//  Bundle+Additions.swift
//  TapAdditionsKit
//
//  Copyright © 2018 Tap Payments. All rights reserved.
//

/// Useful extension for Bundle.
public extension Bundle {
    
    // MARK: - Public -
    // MARK: Methods
    
    /// Returns child bundle with a specific name.
    ///
    /// - Parameter name: Child bundle name.
    /// - Returns: Child bundle.
    public func childBundle(named name: String) -> Bundle? {
        
        guard let bundleURL = self.url(forResource: name, withExtension: BundleConstants.bundleExtension) else {
            
            return nil
        }
        
        return Bundle(url: bundleURL)
    }
    
    // MARK: - Private -
    
    private struct BundleConstants {
        
        fileprivate static let bundleExtension = "bundle"
        
        @available(*, unavailable) private init() {}
    }
}

/// Dummy struct to import Foundation/Bundle module.
public struct BundleAdditions {
    
    @available (*, unavailable) private init() {
        
        fatalError("\(self) cannot be initialized.")
    }
}
