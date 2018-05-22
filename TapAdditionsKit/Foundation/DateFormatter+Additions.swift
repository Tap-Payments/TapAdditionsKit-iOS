//
//  DateFormatter+Additions.swift
//  TapAdditionsKit
//
//  Copyright © 2018 Tap Payments. All rights reserved.
//

import class Foundation.NSDateFormatter.DateFormatter
import struct Foundation.NSLocale.Locale

/// Useful extension to DateFormatter.
public extension DateFormatter {
    
    // MARK: - Public -
    // MARK: Methods
    
    /**
     Initializes new instance of NSDateFormatter with given locale and date format.
     
     - parameter locale:     Locale.
     - parameter dateFormat: Date format.
     
     - returns: New instance of NSDateFormatter.
     */
    public convenience init(locale: Locale, dateFormat: String) {
        
        self.init()
        
        self.locale = locale
        self.dateFormat = dateFormat
    }
}

/// Dummy struct to import Foundation/DateFormatter module.
public struct DateFormatterAdditions {
    
    @available (*, unavailable) private init() {
        
        fatalError("\(self) cannot be initialized.")
    }
}
