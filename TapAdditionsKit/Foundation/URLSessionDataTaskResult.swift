//
//  URLSessionDataTaskResult.swift
//  TapAdditionsKit
//
//  Copyright © 2018 Tap Payments. All rights reserved.
//

import struct Foundation.NSData.Data
import class Foundation.NSURLResponse.URLResponse

/// Structure representing result of URLSessionDataTask
public struct URLSessionDataTaskResult {
    
    // MARK: - Public -
    // MARK: Properties
    
    /// Response data.
    public let data: Data?
    
    /// URL response.
    public let response: URLResponse?
    
    /// Error ( if occured ).
    public let error: Error?
    
    /// Initializes result with data, response and error.
    ///
    /// - Parameters:
    ///   - data: Response data.
    ///   - response: URL response.
    ///   - error: Error ( if occured ).
    public init(data: Data?, response: URLResponse?, error: Error?) {
        
        self.data = data
        self.response = response
        self.error = error
    }
}

/// Dummy struct to import Foundation/URLSessionDataTask module.
public struct URLSessionDataTaskAdditions {
    
    @available (*, unavailable) private init() {
        
        fatalError("\(self) cannot be initialized.")
    }
}
