//
//  Encodable+Additions.swift
//  TapAdditionsKit
//
//  Copyright © 2018 Tap Payments. All rights reserved.
//

import class Foundation.NSJSONSerialization.JSONEncoder
import class Foundation.NSJSONSerialization.JSONSerialization

/// Useful extension to Encodable protocol.
public extension Encodable {
    
    // MARK: - Public -
    // MARK: Methods
    
    /// Encodes the receiver into dictionary.
    ///
    /// - Parameter encoder: Encoder.
    /// - Returns: Dictionary representation of the receiver.
    /// - Throws: Encoding error.
    public func asDictionary(using encoder: JSONEncoder = JSONEncoder()) throws -> [String: Any] {
        
        let data = try encoder.encode(self)
        let object = try JSONSerialization.jsonObject(with: data, options: [])
        
        guard let dictionaryObject = object as? [String: Any] else {
            
            throw EncodingError.invalidValue(object, .init(codingPath: [], debugDescription: "Cannot create dictionary representation of the receiver."))
        }
        
        return dictionaryObject
    }
}
