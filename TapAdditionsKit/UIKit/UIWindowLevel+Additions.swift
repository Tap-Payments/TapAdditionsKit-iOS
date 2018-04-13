//
//  UIWindowLevel+Additions.swift
//  TapAdditionsKit
//
//  Copyright © 2018 Tap Payments. All rights reserved.
//

import struct CoreGraphics.CGBase.CGFloat
import class UIKit.UIApplication.UIApplication
import struct UIKit.UIWindow.UIWindowLevel

/// Useful extension for UIWindowLevel
public extension UIWindowLevel {
    
    // MARK: - Public
    // MARK: Properties
    
    /// Returns maximal window level among all presented windows in the app.
    public static var maximalAmongPresented: UIWindowLevel {
        
        return self.maximalAmongPresented(lower: CGFloat.greatestFiniteMagnitude)
    }

    // MARK: Methods
    
    /// Returns maximal window level among presented in the app lower then the specified window level.
    ///
    /// - Parameter then: Specified window level.
    /// - Returns: Maximal found window level lower then the specified one or 'then' if the window not found.
    public static func maximalAmongPresented(lower then: UIWindowLevel) -> UIWindowLevel {
        
        let windows = UIApplication.shared.windows.filter { $0.windowLevel < then }
        guard windows.count > 0 else { return then }
        
        guard let firstWindow = (windows.sorted { $0.windowLevel > $1.windowLevel }).first else {
         
            fatalError("Something wrong happened. Please recompile.")
        }
        
        return firstWindow.windowLevel
    }
    
    /// Returns minimal window level among presented in the app higher then the specified window level.
    ///
    /// - Parameter then: Specified window level.
    /// - Returns: Minimal found window level higher then the specified one or 'then' if the window not found.
    public static func minimalAmongPresented(higher then: UIWindowLevel) -> UIWindowLevel {
        
        let windows = UIApplication.shared.windows.filter { $0.windowLevel > then }.sorted { $0.windowLevel < $1.windowLevel }
        guard windows.count > 0 else { return then }
        
        return windows[0].windowLevel
    }
}
