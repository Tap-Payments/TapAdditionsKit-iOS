//
//  UIWindow+Additions.swift
//  TapAdditionsKit
//
//  Copyright © 2018 Tap Payments. All rights reserved.
//

import class    UIKit.UIApplication.UIApplication
import class    UIKit.UIWindow.UIWindow

/// Useful UIWindow extension.
public extension UIWindow {
    
    // MARK: - Public -
    // MARK: Properties
    
    /// Returns closest higher window in hierarch (if found).
    public var closestHigherWindow: UIWindow? {
        
        let level = UIWindow.Level.minimalAmongPresented(higher: self.windowLevel)
        guard level != self.windowLevel else { return nil }
        
        return type(of: self).with(level)
    }
    
    /// Returns closest lower window in hierarchy (if found).
    public var closestLowerWindow: UIWindow? {
        
        let level = UIWindow.Level.maximalAmongPresented(lower: self.windowLevel)
        guard level != self.windowLevel else { return nil }
        
        return type(of: self).with(level)
    }

    // MARK: - Private -
    // MARK: Methods
    
    private static func with(_ level: UIWindow.Level) -> UIWindow? {
        
        return UIApplication.shared.windows.filter { $0.windowLevel == level }.first
    }
}

/// Dummy struct to import UIKit/UIWindow module.
public struct UIWindowAdditions {
    
    @available (*, unavailable) private init() {
        
        fatalError("\(self) cannot be initialized.")
    }
}
