//
//  UIGestureRecognizer+Additions.swift
//  TapAdditionsKit
//
//  Copyright © 2018 Tap Payments. All rights reserved.
//

import class UIKit.UIGestureRecognizer.UIGestureRecognizer

/// Useful extension to UIGestureRecognizer
public extension UIGestureRecognizer {
    
    // MARK: - Public -
    // MARK: Methods
    
    /*!
     Cancels current gesture state.
     */
    public func cancelCurrentGesture() {
        
        if self.isEnabled {
            
            self.isEnabled = false
            self.isEnabled = true
        }
    }
}

/// Dummy struct to import UIKit/UIGestureRecognizer module.
public struct UIGestureRecognizerAdditions {
    
    @available (*, unavailable) private init() {
        
        fatalError("\(self) cannot be initialized.")
    }
}
