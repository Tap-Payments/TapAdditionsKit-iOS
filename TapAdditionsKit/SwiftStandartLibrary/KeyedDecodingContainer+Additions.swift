//
//  KeyedDecodingContainer+Additions.swift
//  TapAdditionsKit
//
//  Copyright © 2018 Tap Payments. All rights reserved.
//

/// Useful extensions to KeyedDecodingContainer.
public extension KeyedDecodingContainer {
    
    // MARK: - Public -
    // MARK: Methods
    
    /// Decodes model if it is presented for a given key.
    ///
    /// - Parameters:
    ///   - type: Model type.
    ///   - key: Key.
    /// - Returns: Model
    /// - Throws: Decoding error if any.
    public func decodeIfPresentAndNotEmpty<Model>(_ type: Model.Type, forKey key: KeyedDecodingContainer.Key) throws -> Model? where Model: Decodable {
        
        guard self.contains(key) else { return nil }
        guard try self.decodeNil(forKey: key) == false else { return nil }
        
        let anyDecodable = try self.decode(AnyDecodable.self, forKey: key)
        guard let dictionary = anyDecodable.value as? [String: Any] else {
            
            throw DecodingError.dataCorrupted(DecodingError.Context(codingPath: self.codingPath, debugDescription: "Expected dictionary."))
        }
        
        guard dictionary.count > 0 else { return nil }
        
        return try self.decode(Model.self, forKey: key)
    }
    
    /// Decodes integer for a given key.
    ///
    /// - Parameter key: Key.
    /// - Returns: Decoded integer.
    /// - Throws: Decoding error if any.
    public func decodeInt(forKey key: Key) throws -> Int {
        
        if let intValue = try? self.decode(Int.self, forKey: key) {
            
            return intValue
        }
        else {
            
            let stringValue = try self.decode(String.self, forKey: key)
            if let intValue = Int(stringValue) {
                
                return intValue
            }
            else {
                
                throw DecodingError.dataCorrupted(DecodingError.Context(codingPath: self.codingPath, debugDescription: "Given string is not a valid integer"))
            }
        }
    }
}

private struct AnyDecodable: Decodable {
    
    fileprivate var value: Any
    
    private struct CodingKeys: CodingKey {
        
        var stringValue: String
        var intValue: Int?
        
        init?(intValue: Int) {
            
            self.stringValue = "\(intValue)"
            self.intValue = intValue
        }
        init?(stringValue: String) {
            
            self.stringValue = stringValue
            
        }
    }
    
    fileprivate init(from decoder: Decoder) throws {
        
        if let container = try? decoder.container(keyedBy: CodingKeys.self) {
            
            var result = [String: Any]()
            try container.allKeys.forEach { (key) throws in
                
                result[key.stringValue] = try container.decode(AnyDecodable.self, forKey: key).value
            }
            
            value = result
            
        } else if var container = try? decoder.unkeyedContainer() {
            
            var result = [Any]()
            
            while !container.isAtEnd {
                
                result.append(try container.decode(AnyDecodable.self).value)
            }
            
            value = result
            
        } else if let container = try? decoder.singleValueContainer() {
            
            if let intVal = try? container.decode(Int.self) {
                
                value = intVal
                
            } else if let doubleVal = try? container.decode(Double.self) {
                
                value = doubleVal
                
            } else if let boolVal = try? container.decode(Bool.self) {
                
                value = boolVal
                
            } else if let stringVal = try? container.decode(String.self) {
                
                value = stringVal
                
            } else {
                
                throw DecodingError.dataCorruptedError(in: container, debugDescription: "The container contains nothing serializable.")
            }
            
        } else {
            
            throw DecodingError.dataCorrupted(DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Could not deserialise."))
        }
    }
}