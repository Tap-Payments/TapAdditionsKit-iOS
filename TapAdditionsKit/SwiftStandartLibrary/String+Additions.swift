//
//  String+Additions.swift
//  TapAdditionsKit
//
//  Copyright © 2018 Tap Payments. All rights reserved.
//

import struct CoreGraphics.CGGeometry.CGRect
import struct CoreGraphics.CGGeometry.CGSize
import struct Foundation.NSAttributedString.NSAttributedStringKey
import class Foundation.NSString
import class UIKit.NSStringDrawingContext
import struct UIKit.NSStringDrawingOptions

/// Useful extension to String.
public extension String {
    
    // MARK: - Public -
    // MARK: Properties
    
    /// Empty string.
    public static let empty = ""
    
    /// Empty JSON dictionary string.
    public static let emptyJSONDictionary = "{}"
    
    /// Empty JSON array string.
    public static let emptyJSONArray = "[]"
    
    /// Returns length of the receiver.
    public var length: Int {
        
        return self.count
    }
    
    /// Returns reversed string.
    public var reversed: String {
        
        return String(self.reversed())
    }
    
    /// Returns last path component of the receiver.
    public var lastPathComponent: String {

        let reversedString = self.reversed
        if let range = reversedString.range(of: Constants.slashCharacter) {

            return String(reversedString[..<range.lowerBound]).reversed
        }

        return .empty
    }
    
    /// Returns path extension of the receiver.
    public var pathExtension: String {
        
        return (self as NSString).pathExtension
    }
    
    /// Defines if the receiver contains only digits.
    public var containsOnlyDigits: Bool {
        
        return self.isValid(for: Constants.digitsOnlyRegex)
    }
    
    /// Defines if receiver contains only international digits.
    public var containsOnlyInternationalDigits: Bool {
        
        return self.isValid(for: Constants.internationalDigitsOnlyRegex)
    }
    
    /// Defines if receiver is a valid number string.
    public var isValidNumber: Bool {
        
        return self.isValid(for: Constants.numberRegex)
    }
    
    /// Returns integer value of the receiver.
    public var integerValue: Int {
        
        return (self as NSString).integerValue
    }
    
    /// Returns decimal number value of the receiver if it is a valid number, nil otherwise.
    public var decimalValue: Decimal? {
        
        guard self.isValidNumber else { return nil }
        
        type(of: self).numberFormatter.generatesDecimalNumbers = true
        return type(of: self).numberFormatter.number(from: self) as? Decimal
    }
    
    /// Returns double value.
    public var doubleValue: Double {
        
        return (self as NSString).doubleValue
    }
    
    /// Defines if receiver is a valid email address.
    public var isValidEmailAddress: Bool {
        
        return self.isValid(for: Constants.validEmailRegex) && self.length <= Constants.maximalEmailLength
    }
    
    /// Defines if receiver passes Luhn algorithm.
    public var isValidLuhn: Bool {

        guard self.containsOnlyInternationalDigits else { return false }
        
        var sum = 0
        let digits = self.charactersArray.reversed()
        
        for (index, digitString) in digits.enumerated() {
            
            let digit = digitString.integerValue
            let odd = index % 2 == 1
            
            switch (odd, digit) {
                
            case (true, 9):
                
                sum += 9
                
            case (true, 0...8):
                
                sum += ( digit * 2 ) % 9
                
            default:
                
                sum += digit
            }
        }
        
        return sum % 10 == 0
    }
    
    /// Removes path extension from the receiver.
    ///
    /// - Returns: Copy of the receiver without path extension.
    public var deletingPathExtension: String {
        
        return (self as NSString).deletingPathExtension
    }
    
    /// Returns URL encoded receiver.
    public var urlEncoded: String {
        
        let characters = NSCharacterSet.urlQueryAllowed
        
        guard let encodedString = self.addingPercentEncoding(withAllowedCharacters: characters) else {
            
            return self
        }
        
        return encodedString
    }
    
    /// Characters array.
    public var charactersArray: [String] {
        
        return self.map { String($0) }
    }
    
    // MARK: Methods
    
    /// Initializes string from the strings contained in lines array, adding a separator between them.
    ///
    /// - Parameters:
    ///   - separator: Separator string.
    ///   - lines: Lines array.
    public init(separator: String, lines: String...) {
        
        self = .empty
        
        let linesCount = lines.count
        guard linesCount > 0 else { return }
        
        for (index, line) in lines.enumerated() {
            
            self += line
            
            if index < linesCount - 1 {
                
                self += separator
            }
        }
    }
    
    /// Returns a string by appending path component to the receiver.
    ///
    /// - Parameter path: Path component to append.
    /// - Returns: Receiver copy with appended path component.
    public func appendingPathComponent(_ path: String) -> String {
        
        return (self as NSString).appendingPathComponent(path)
    }
    
    /// Returns a string by appending path extension to the receiver.
    ///
    /// - Parameter path: Path extension to append.
    /// - Returns: Receiver copy with appended path extension.
    public func appendingPathExtension(_ path: String) -> String? {
        
        return (self as NSString).appendingPathExtension(path)
    }
    
    /// Compares two strings using NSString isEqual: method.
    ///
    /// - Parameter other: Other string.
    /// - Returns: Boolean value which determines whether the strings are equal.
    public func isEqual(to other: String?) -> Bool {
        
        guard let nonnullOther = other else { return false }
        
        return (self as NSString).isEqual(to: nonnullOther)
    }
    
    /// Regular expression check on the receiver.
    ///
    /// - Parameter pattern: Regular expression.
    /// - Returns: Boolean value which determines whether the string is valid for the given regular expression.
    public func isValid(for pattern: String?) -> Bool {
        
        guard let nonnullPattern = pattern else { return false }
        
        guard let regex = try? NSRegularExpression(pattern: nonnullPattern, options: .caseInsensitive) else {
            
            print("Failed to create regular expression from the pattern '\(nonnullPattern)'.")
            return false
        }
    
        let selfLength = self.length
        
        let textRange = NSRange(location: 0, length: selfLength)
        let matchRange = regex.rangeOfFirstMatch(in: self, options: .reportProgress, range: textRange)
        
        return ( matchRange.location != NSNotFound ) && ( matchRange.location == 0 && matchRange.length == selfLength )
    }
    
    /// Defines if the receiver has matches for the given regular expression.
    ///
    /// - Parameter pattern: Regular expression.
    /// - Returns: Boolean value which determines if there are matches for the given pattern.
    public func hasMatches(for pattern: String?) -> Bool {
        
        guard let nonnullPattern = pattern else { return false }
        
        guard let regex = try? NSRegularExpression(pattern: nonnullPattern, options: .caseInsensitive) else {
            
            return false
        }
        
        let textRange = NSRange(location: 0, length: self.length)
        let matchRange = regex.rangeOfFirstMatch(in: self, options: .reportProgress, range: textRange)
        return matchRange.location != NSNotFound
    }
    
    /// Defines if the receiver includes a given substring ignoring case.
    ///
    /// - Parameter searchText: Substring to search.
    /// - Returns: Boolean
    public func containsIgnoringCase(_ searchText: String) -> Bool {
        
        return self.range(of: searchText, options: .caseInsensitive) != nil
    }
    
    /// Returns a substring from a given index.
    ///
    /// - Parameter index: Index.
    /// - Returns: Substring.
    public func substring(from index: Int) -> String {
        
        return String(self.suffix(from: index.index(in: self)))
    }
    
    /// Returns a substring to a given index.
    ///
    /// - Parameter index: Index.
    /// - Returns: Substring.
    public func substring(to index: Int) -> String {
        
        return String(self.prefix(upTo: index.index(in: self)))
    }
    
    /// Returns a substring with a given NSRange.
    ///
    /// - Parameter range: NSRange.
    /// - Returns: Substring.
    public func substring(with range: NSRange) -> String? {
        
        guard let swiftRange = self.range(from: range) else { return nil }
        
        let substring = self[swiftRange]
        return String(substring)
    }
    
    /// Returns NSRange of a substring.
    ///
    /// - Parameter string: Substring.
    /// - Returns: NSRange.
    public func nsRange(of string: String) -> NSRange? {
        
        guard let swiftRange = self.range(of: string) else { return nil }
        return self.nsRange(from: swiftRange)
    }
    
    /// Replaces given range with a given substring.
    ///
    /// - Parameters:
    ///   - range: NSRange.
    ///   - string: String to replace with.
    /// - Returns: String with replaced range.
    @discardableResult public mutating func replace(range: NSRange, withString string: String) -> String {
        
        self = self.replacing(range: range, withString: string)
        
        return self
    }
    
    /// Replaces given range with a given substring.
    ///
    /// - Parameters:
    ///   - range: NSRange.
    ///   - string: String to replace with.
    /// - Returns: String with replaced range.
    public func replacing(range: NSRange, withString string: String) -> String {
        
        guard let swiftRange = self.range(from: range) else { return self }
        
        return self.replacingCharacters(in: swiftRange, with: string)
    }
    
    /// Replaces first occurrence tagret string with replace string from initial string
    ///
    /// - Parameters:
    ///   - string: string to be replaced
    ///   - replaceString: string to replace
    /// - Returns: string with replaced value
    public func replacingFirstOccurrence(of string: String, with replaceString: String) -> String {
        
        if let range = self.range(of: string) {
            
            return self.replacingCharacters(in: range, with: replaceString)
        }
        
        return String(self)
    }
    
    /// Replaces first occurrence tagret string with replace string from initial string
    ///
    /// - Parameters:
    ///   - string: string to be replaced
    ///   - replaceString: string to replace
    /// - Returns: string with replaced value
    @discardableResult public mutating func replaceFirstOccurrence(of string: String, with replaceString: String) -> String {
        
        guard let range = self.nsRange(of: string) else { return self }
        
        self.replace(range: range, withString: replaceString)
        
        return self
    }
    
    /// Appends given string to the receiver.
    ///
    /// - Parameter string: String to append.
    /// - Returns: Receiver + appended string.
    public mutating func append(string: String) -> String {
        
        self = self.appending(string)
        
        return self
    }
    
    /// Graphics method. Returns required bounding rect to draw the receiver with the given parameters.
    ///
    /// - Parameters:
    ///   - size: Size limit.
    ///   - options: String drawing options.
    ///   - attributes: Text attributes ( font, size, etc. )
    ///   - context: Context.
    /// - Returns: CGRect
    public func boundingRect(with size: CGSize, options: NSStringDrawingOptions, attributes: [NSAttributedStringKey: Any]?, context: NSStringDrawingContext?) -> CGRect {
        
        return (self as NSString).boundingRect(with: size, options: options, attributes: attributes, context: context)
    }
    
    /// Removes all characters of the receiver except those specified in the string.
    ///
    /// - Parameter charactersString: Valid characters string.
    /// - Returns: Copy of the receiver by removing all invalid characters.
    public func byRemovingAllCharactersExcept(_ charactersString: String) -> String {
        
        var result: String = .empty
        
        for character in self {
            
            if charactersString.contains(character) {
                
                result.append(character)
            }
        }
        
        return result
    }
    
    /// Helper method to convert Range<String.Index> to NSRange.
    ///
    /// - Parameter range: Swift range.
    /// - Returns: NSRange.
    public func nsRange(from range: Range<Index>) -> NSRange {
        
        let utf16View = self.utf16
        
        guard let from = range.lowerBound.samePosition(in: utf16View), let to = range.upperBound.samePosition(in: utf16View) else {
            
            return NSRange(location: NSNotFound, length: 0)
        }
        
        return NSRange(location: utf16View.distance(from: utf16View.startIndex, to: from), length: utf16View.distance(from: from, to: to))
    }
    
    /// Helper method to convert NSRange to Range<String.Index>.
    ///
    /// - Parameter nsRange: NSRange
    /// - Returns: Swift range.
    public func range(from nsRange: NSRange) -> Range<String.Index>? {

        let utf16View = self.utf16
        let endIndex = utf16View.endIndex
        
        guard let from16 = utf16View.index(utf16View.startIndex, offsetBy: nsRange.location, limitedBy: endIndex) else { return nil }
        guard let to16 = utf16View.index(from16, offsetBy: nsRange.length, limitedBy: endIndex) else { return nil }
        
        guard let from = String.Index(from16, within: self) else { return nil }
        guard let to = String.Index(to16, within: self) else { return nil }
        
        return from ..< to
    }
    
    // MARK: - Private -
    
    private struct Constants {
        
        fileprivate static let slashCharacter = "/"
        fileprivate static let numberRegex = "^[\\p{N}]*[.,٬·٫]{0,1}[\\p{N}]*$"
        fileprivate static let digitsOnlyRegex = "^[\\p{N}]*$"
        fileprivate static let internationalDigitsOnlyRegex = "^[0-9]*$"
        fileprivate static let maximalEmailLength = 254
        fileprivate static let validEmailRegex = "^.+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2}[A-Za-z]*$"
    }
    
    // MARK: Properties
    
    private static let numberFormatter = NumberFormatter(localeIdentifier: Locale.LocaleIdentifier.enUS)
}

// MARK: - RawRepresentable
extension String: RawRepresentable {
    
    public typealias RawValue = String
    
    public init?(rawValue: String.RawValue) {
        
        self.init()
        self.append(rawValue)
    }
    
    public var rawValue: String.RawValue {
        
        return self
    }
}

// MARK: - ExpressibleByIntegerLiteral
extension String: ExpressibleByIntegerLiteral {
    
    public init(integerLiteral value: Int) {
        
        self = "\(value)"
    }
}

/// Dummy struct to import SwiftStandartLibrary/String module.
public struct StringAdditions {
    
    @available (*, unavailable) private init() {
        
        fatalError("\(self) cannot be initialized.")
    }
}
