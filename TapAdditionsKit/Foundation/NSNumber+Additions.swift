//
//  NSNumber+Additions.swift
//  TapAdditionsKit
//
//  Copyright © 2018 Tap Payments. All rights reserved.
//

import struct CoreGraphics.CGBase.CGFloat
import class UIKit.UIDevice.UIDevice

/// Useful extension for NSNumber.
public extension NSNumber {
    
    // MARK: - Public -
    // MARK: Properties
    
    /// Zero number.
    public static let zero = NSNumber(value: 0.0)
    
    /// Returns CGFloat value.
    public var cgFloatValue: CGFloat {
        
        if UIDevice.current.is64Bit {
            
            return CGFloat(self.floatValue)
        }
        else {
            
            return CGFloat(self.doubleValue)
        }
    }
    
    /// Returns string value of the receiver using en_US locale without grouping separator.
    public var internationalStringValue: String {
        
        if let result = type(of: self).decimalNumberFormatter.string(from: self) {
            
            return result
        }
        else {
            
            return "0"
        }
    }
    
    // MARK: Methods
    
    /*!
     Initialized NSNumber with CGFloat value.
     
     - parameter value: Value
     
     - returns: NSNumber
     */
    public convenience init(cgFloat value: CGFloat) {
        
        if UIDevice.current.is64Bit {
            
            self.init(value: Double(value))
        }
        else {
            
            self.init(value: Float(value))
        }
    }
    
    /*!
     Creates and returns number from a given string.
     
     - parameter string: String to generate number.
     
     - returns: NSNumber
     */
    public static func from(string: String?) -> NSNumber {
        
        guard let nonnullString = string else { return .zero }
        
        if let numberFromString = self.decimalNumberFormatter.number(from: nonnullString) {
            
            return numberFromString
        }
        else {
            
            return .zero
        }
    }
    
    // MARK: Private
    
    private static var decimalNumberFormatter: NumberFormatter = {
        
        let formatter = NumberFormatter(locale: Locale.enUS)
        formatter.groupingSeparator = String.empty
        formatter.numberStyle = NumberFormatter.Style.decimal
        
        return formatter
    }()
}

/// Dummy struct to import Foundation/NSNumber module.
public struct NSNumberAdditions {
    
    @available (*, unavailable) private init() {
        
        fatalError("\(self) cannot be initialized.")
    }
}
