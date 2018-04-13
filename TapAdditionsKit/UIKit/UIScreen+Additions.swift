//
//  UIScreen+Additions.swift
//  TapAdditionsKit
//
//  Copyright © 2018 Tap Payments. All rights reserved.
//

import struct CoreGraphics.CGBase.CGFloat
import class UIKit.UIScreen

/// Useful extension for UIScreen class.
public extension UIScreen {
    
    // MARK: - Public -
    // MARK: Properties

    /// Returns number of points in one pixel.
    public var numberOfPointsInOnePixel: CGFloat {
        
        return 1.0 / self.scale
    }
}
