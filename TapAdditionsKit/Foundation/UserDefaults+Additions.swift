//
//  UserDefaults+Additions.swift
//  TapAdditionsKit
//
//  Copyright © 2018 Tap Payments. All rights reserved.
//

import class Foundation.NSNull.NSNull
import class Foundation.NSThread.Thread
import class Foundation.NSUserDefaults.UserDefaults

/// Useful extension to UserDefaults.
public extension UserDefaults {
    
    // MARK: - Public -
    // MARK: Methods
    
    /// Saves the value into the receiver synchronously on the main thread.
    ///
    /// - Parameters:
    ///   - value: Value to store.
    ///   - key: Key.
    public func synchronouslySetOnMainThread(_ value: Any?, for key: String) {
        
        guard Thread.isMainThread else {
            
            let dict = [key: value ?? NSNull()]
            
            self.performSelector(onMainThread: #selector(synchronouslySetOnMainThread(_:)), with: dict, waitUntilDone: true)
            return
        }
        
        if let nonnullValue = value {
            
            self.set(nonnullValue, forKey: key)
        }
        else {
            
            self.removeObject(forKey: key)
        }
        
        self.synchronize()
    }
    
    // MARK: - Private -
    // MARK: Methods
    
    @objc private func synchronouslySetOnMainThread(_ args: [String: Any]) {
        
        for (key, value) in args {
            
            self.synchronouslySetOnMainThread(value is NSNull ? nil : value, for: key)
        }
    }
}

public func saveSynchronouslyToStandartUserDefaults(_ value: Any?, for key: String) {
    
    UserDefaults.standard.synchronouslySetOnMainThread(value, for: key)
}

/// Dummy struct to import Foundation/UserDefaults module.
public struct UserDefaultsAdditions {
    
    @available (*, unavailable) private init() {
        
        fatalError("\(self) cannot be initialized.")
    }
}
