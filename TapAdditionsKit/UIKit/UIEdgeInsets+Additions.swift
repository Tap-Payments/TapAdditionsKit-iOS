//
//  UIEdgeInsets+Additions.swift
//  TapAdditionsKit
//
//  Copyright © 2018 Tap Payments. All rights reserved.
//

import struct CoreGraphics.CGBase.CGFloat
import struct UIKit.UIGeometry.UIEdgeInsets

/// Useful addition to UIEdgeInsets.
public extension UIEdgeInsets {
    
    // MARK: - Public -
    // MARK: Properties
    
    /// Returns mirrored result.
    public var mirrored: UIEdgeInsets {
        
        let original = self
        
        var result = self
        result.left = original.right
        result.right = original.left
        
        return result
    }
    
    // MARK: Methods
    
    /// Initializes UIEdgeInsets with the same insets from all sides.
    ///
    /// - Parameter inset: Inset.
    public init(_ inset: CGFloat) {
        
        self.init(top: inset, left: inset, bottom: inset, right: inset)
    }
}

/// Dummy struct to import UIKit/UIEdgeInsets module.
public struct UIEdgeInsetsAdditions {
    
    @available (*, unavailable) private init() {
        
        fatalError("\(self) cannot be initialized.")
    }
}
