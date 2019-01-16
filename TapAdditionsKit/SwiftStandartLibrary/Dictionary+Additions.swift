//
//  Dictionary+Additions.swift
//  TapAdditionsKit
//
//  Copyright © 2019 Tap Payments. All rights reserved.
//

/// OptionalType protocol.
public protocol OptionalType {
    
    associatedtype Wrapped
    
    /// Returns optional representation of the receiver.
    var tap_asOptional: Wrapped? { get }
}

// MARK: - OptionalType
extension Optional: OptionalType {
    
    public var tap_asOptional: Wrapped? {
        
        return self
    }
}

/// Useful extension to Dictionary class.
public extension Dictionary {
    
    // MARK: - Public -
    // MARK: Properties
    
    /// Returns array of all keys of the receiver.
    public var tap_allKeys: [Key] {
        
        return self.map { $0.key }
    }
    
    /// Returns array of all values of the receiver.
    public var tap_allValues: [Value] {
        
        return self.map { $0.value }
    }
    
    // MARK: Methods
    
    /**
     Sets value for a given key. If value is nil, then does nothing.
     
     - parameter value: Value.
     - parameter key:   Key.
     */
    public mutating func tap_setValue(_ value: Value?, forKey key: Key) {
        
        if let nonnullValue = value {
            
            self[key] = nonnullValue
        }
        else {
            
            self.removeValue(forKey: key)
        }
    }
    
    /// + operator for same typed dictionaries.
    ///
    /// - Parameters:
    ///   - lhs: Left operand.
    ///   - rhs: Right operand.
    /// - Returns: lhs + rhs
    public static func +<Key, Value>(lhs: [Key: Value], rhs: [Key: Value]) -> [Key: Value] {
        
        var result: [Key: Value] = [:]
        for (key, value) in lhs {
            
            result[key] = value
        }
        
        for (key, value) in rhs {
            
            result[key] = value
        }
        
        return result
    }
    
    /// += operator for same typed dictionaries.
    ///
    /// - Parameters:
    ///   - lhs: Receiver.
    ///   - rhs: Right operand.
    /// - Returns: lhs = lhs + rhs
    @discardableResult public static func +=<Key, Value>(lhs: inout [Key: Value], rhs: [Key: Value]) -> [Key: Value] {
        
        for (key, value) in rhs {
            
            lhs[key] = value
        }
        
        return lhs
    }
    
    /// Maps the receiver keys.
    ///
    /// - Parameter transform: Key transform.
    /// - Returns: Mapped dictionary.
    /// - Throws: Mapped dictionary.
    public func tap_mapKeys<T>(_ transform: (Dictionary.Key) throws -> T) rethrows -> [T: Dictionary.Value] {
        
        var result: [T: Dictionary.Value] = [:]
        
        for (key, value) in self {
            
            do {
                
                let mappedKey = try transform(key)
                result[mappedKey] = value
            }
            catch { }
        }
        
        return result
    }
}

// MARK: - OptionalType
extension Dictionary where Value: OptionalType {
    
    /// Returns non-optional representation of the receiver.
    public var tap_nonOptionalRepresentation: [Key: Value.Wrapped] {
        
        var result: [Key: Value.Wrapped] = [:]
        
        for (key, value) in self {
            
            if let unwrappedValue = value.tap_asOptional {
                
                result[key] = unwrappedValue
            }
        }
        
        return result
    }
}

// MARK: - Compare nested dictionaries.
public extension Dictionary where Value == [AnyHashable: Equatable] {
    
    /// Compares two nested dictionaries.
    ///
    /// - Parameters:
    ///   - lhs: Left operand.
    ///   - rhs: Right operand.
    /// - Returns: Boolean value which determines whether two dictionaries are equal.
    public static func == <V: Equatable, K>(lhs: [Key: [K: V]], rhs: [Key: [K: V]]) -> Bool {

        guard lhs.count == rhs.count else { return false }
        
        for (key, lhsub) in lhs {
            
            if let rhsub = rhs[key] {
                
                if lhsub != rhsub {
                    
                    return false
                }
            }
            else {
                
                return false
            }
        }
        
        return true
    }
    
    /// Compares two nested dictionaries.
    ///
    /// - Parameters:
    ///   - lhs: Left operand.
    ///   - rhs: Right operand.
    /// - Returns: Boolean value which determines whether two dictionaries are not equal.
    public static func !=<V: Equatable, K>(lhs: [Key: [K: V]], rhs: [Key: [K: V]]) -> Bool {
        
        return !(lhs == rhs)
    }
}
