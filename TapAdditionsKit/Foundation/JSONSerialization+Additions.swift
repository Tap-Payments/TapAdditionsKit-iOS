//
//  JSONSerialization+Additions.swift
//  TapAdditionsKit
//
//  Copyright © 2018 Tap Payments. All rights reserved.
//

import func TapSwiftFixes.ExceptionCatcher.catchException

/// JSON Serialization protocol.
public protocol JSONSerializable {
    
    // MARK: - Public -
    // MARK: Methods
    
    /// Generates JSON string with the given JSON writing options and resulting string encoding.
    ///
    /// - Parameters:
    ///   - options: JSON writing options.
    ///   - encoding: String encoding.
    /// - Returns: JSON string or empty string if the receiver is not a valid json object.
    func serializedToJSONString(with options: JSONSerialization.WritingOptions, encoding: String.Encoding) -> String
}

public extension JSONSerializable {
    
    /// Defines if the receiver is a valid JSON object.
    public var isValidJSONObject: Bool {
        
        return JSONSerialization.isValidJSONObject(self)
    }
    
    /// Returns JSON string of the receiver or empty JSON dictionary if the receiver is not a valid json object.
    public var jsonString: String {
     
        return self.serializedToJSONString(with: .none, encoding: .utf8)
    }
}

/// JSON Safe Serialization protocol.
public protocol JSONSafeSerializable: JSONSerializable {
    
    /// Generates 'safe' JSON object by removing everything that cannot be serialized to JSON ( e.g. lossy JSON object ).
    var safeJSONObject: Self { get }
}

extension JSONSafeSerializable {
    
    /// Generates 'safe' JSON string by removing everything that cannot be serialized to JSON ( e.g. lossy JSON string ).
    public var safeJSONString: String {
        
        return self.safeJSONObject.jsonString
    }
}

extension Array: JSONSerializable {
    
    public func serializedToJSONString(with options: JSONSerialization.WritingOptions, encoding: String.Encoding) -> String {
        
        return JSONSerialization.string(fromJSONObject: self, options: options, encoding: encoding) ?? .emptyJSONArray
    }
}

extension Dictionary: JSONSerializable {
    
    public func serializedToJSONString(with options: JSONSerialization.WritingOptions, encoding: String.Encoding) -> String {
    
        return JSONSerialization.string(fromJSONObject: self, options: options, encoding: encoding) ?? .emptyJSONDictionary
    }
}

fileprivate extension JSONSerialization {
    
    fileprivate static func string(fromJSONObject object: JSONSerializable, options: JSONSerialization.WritingOptions, encoding: String.Encoding) -> String? {
        
        guard object.isValidJSONObject else { return nil }
        
        var error: NSError?
        var data: Data?
        
        let closure: TypeAlias.ArgumentlessClosure = {
            
            data = try? JSONSerialization.data(withJSONObject: object, options: options)
        }
        
        catchException(closure, &error)
        
        if let nonnullData = data {
            
            return String(data: nonnullData, encoding: encoding)
        }
        else {
            
            return nil
        }
    }
}

extension Array: JSONSafeSerializable {
    
    public var safeJSONObject: [Element] {
    
        let result = self.compactMap { safelySerializableObject($0) }
        
        if result.isValidJSONObject {
            
            return result
        }
        else {
            
            return []
        }
    }
}

extension Dictionary: JSONSafeSerializable {
    
    public var safeJSONObject: [Key: Value] {
        
        var result: [Key: Value] = [:]
        
        for (key, value) in self {
            
            guard key is String else { continue }
            
            if let safeValue = safelySerializableObject(value) {
                
                result[key] = safeValue
            }
        }
        
        if result.isValidJSONObject {
            
            return result
        }
        else {
         
            return [:]
        }
    }
}

private func safelySerializableObject<T>(_ object: T) -> T? {
    
    if let arrayObject = object as? [Any] {
        
        return arrayObject.safeJSONObject as? T
    }
    else if let dictionaryObject = object as? [AnyHashable: Any] {
        
        return dictionaryObject.safeJSONObject as? T
    }
    else if [object].isValidJSONObject {
        
        return object
    }
    else {
        
        return nil
    }
}
