//
//  URLSession+Additions.swift
//  TapAdditionsKit
//
//  Copyright © 2018 Tap Payments. All rights reserved.
//

import class Dispatch.DispatchSemaphore
import struct Foundation.NSData.Data
import struct Foundation.NSURLRequest.URLRequest
import class Foundation.NSURLResponse.URLResponse
import class Foundation.NSURLSession.URLSession

/// Useful extension of URLSession.
public extension URLSession {
    
    // MARK: - Public -
    // MARK: Methods
    
    /// Static synchronous data task.
    ///
    /// - Parameter request: Request.
    /// - Returns: Tuple: (data, response, error)
    public static func synchronousDataTask(with request: URLRequest) -> URLSessionDataTaskResult {
        
        return URLSession.shared.synchronousDataTask(with: request)
    }
    
    /// Synchronous data task.
    ///
    /// - Parameter request: Request.
    /// - Returns: Tuple: (data, response, error)
    public func synchronousDataTask(with request: URLRequest) -> URLSessionDataTaskResult {
        
        var data: Data?
        var response: URLResponse?
        var error: Error?
        
        let semaphore = DispatchSemaphore(value: 0)
        
        let dataTask = self.dataTask(with: request) {
            
            data = $0
            response = $1
            error = $2
            
            semaphore.signal()
        }
        
        dataTask.resume()
        
        _ = semaphore.wait(timeout: .distantFuture)
        
        return URLSessionDataTaskResult(data: data, response: response, error: error)
    }
}

/// Dummy struct to import Foundation/URLSession module.
public struct URLSessionAdditions {
    
    @available (*, unavailable) private init() {
        
        fatalError("\(self) cannot be initialized.")
    }
}
