//
//  Locale+Additions.swift
//  TapAdditionsKit
//
//  Copyright © 2018 Tap Payments. All rights reserved.
//

import struct Foundation.CharacterSet
import struct Foundation.NSLocale.Locale
import class Foundation.NSLocale.NSLocale

/// Useful extension to Locale class.
public extension Locale {
    
    // MARK: - Public -
    // MARK: Properties
    
    /// Returns en_US locale.
    public static let enUS = Locale(identifier: LocaleIdentifier.enUS)
    
    /// Locale identifiers.
    public struct LocaleIdentifier {
        
        public static let ar = "ar"
        public static let en = "en"
        public static let enUS = "en_US"
    }
    
    // MARK: Methods
    
    /// Returns primary locale identifier from a given locale identifier.
    ///
    /// - Parameter localeIdentifier: Locale identifier, for example "en-US"
    /// - Returns: Primary locale identifier, for example "en".
    public static func primaryLocaleIdentifier(from localeIdentifier: String) -> String {
        
        let languageCodeKey = NSLocale.Key.languageCode.rawValue
        let components = self.components(fromIdentifier: localeIdentifier)
        
        if let result = components[languageCodeKey] {
            
            return result
        }
        
        let characters = "\(LocaleSeparator.dash)\(LocaleSeparator.underscore)"
        let charactersSet = CharacterSet(charactersIn: characters)
        
        return localeIdentifier.components(separatedBy: charactersSet)[0]
    }
    
    // MARK: - Private -
    private struct LocaleSeparator {
        
        fileprivate static let dash = "-"
        fileprivate static let underscore = "_"
    }
}

/// Dummy struct to import Foundation/Locale module.
public struct LocaleAdditions {
    
    @available (*, unavailable) private init() {
        
        fatalError("\(self) cannot be initialized.")
    }
}
