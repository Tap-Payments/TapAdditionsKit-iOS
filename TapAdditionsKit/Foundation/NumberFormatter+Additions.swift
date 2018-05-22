//
//  NumberFormatter+Additions.swift
//  TapAdditionsKit
//
//  Copyright © 2018 Tap Payments. All rights reserved.
//

import struct Foundation.NSLocale.Locale
import class Foundation.NSNumberFormatter.NumberFormatter

/// Useful extension for NumberFormatter.
public extension NumberFormatter {
    
    // MARK: - Public -
    // MARK: Methods
    
    /// Initializes NumberFormatter with a given locale identifer.
    ///
    /// - Parameter localeIdentifier: Locale identifier.
    public convenience init(localeIdentifier: String) {
        
        let loc = Locale(identifier: localeIdentifier)
        self.init(locale: loc)
    }
    
    /// Initializes number formatter with a given locale.
    ///
    /// - Parameter locale: Locale.
    public convenience init(locale: Locale) {
        
        self.init()
        self.locale = locale
    }
}

/// Dummy struct to import Foundation/NumberFormatter module.
public struct NumberFormatterAdditions {
    
    @available (*, unavailable) private init() {
        
        fatalError("\(self) cannot be initialized.")
    }
}
