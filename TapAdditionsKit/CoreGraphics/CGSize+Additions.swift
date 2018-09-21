//
//  CGSize+Additions.swift
//  TapAdditionsKit
//
//  Copyright © 2018 Tap Payments. All rights reserved.
//

import struct   CoreGraphics.CGBase.CGFloat
import struct   CoreGraphics.CGGeometry.CGPoint
import struct   CoreGraphics.CGGeometry.CGSize
import func     Darwin.ceil
import func     Darwin.floor
import struct   OpenGLES.gltypes.GLfloat

/// Useful addition to CGSize.
public extension CGSize {
    
    // MARK: - Public -
    // MARK: Properties
    
    /// Minimal image size in pixels to upload to Instagram.
    public static let minimalInstagramImageSizeInPixels: CGSize = CGSize(dimension: 612.0)
    
    /// Returns area.
    public var area: CGFloat {
        
        return self.width * self.height
    }
    
    /// Returns CGSize as CGPoint
    public var asCGPoint: CGPoint {
        
        return CGPoint(x: self.width, y: self.height)
    }
    
    /// Returns vec2 representation of CGSize.
    public var asVec2: [GLfloat] {
        
        return [GLfloat(self.width), GLfloat(self.height)]
    }
    
    /// Returns ceiled receiver.
    public var ceiled: CGSize {
        
        return CGSize(width: ceil(self.width), height: ceil(self.height))
    }
    
    /// Returns floored receiver.
    public var floored: CGSize {
        
        return CGSize(width: floor(self.width), height: floor(self.height))
    }
    
    /// Returns maximal allowed corner radius.
    public var maximalCornerRadus: CGFloat {
        
        return 0.5 * min(self.width, self.height)
    }
    
    /// Defines if size has square form.
    public var isSquare: Bool {
        
        return self.width == self.height
    }
    
    // MARK: Methods
    
    /// Initializes square size with the given `dimension`.
    ///
    /// - Parameter dimension: Dimension.
    public init(dimension: CGFloat) {
        
        self.init(width: dimension, height: dimension)
    }
    
    /// Defines if the receiver fully fits into `size`.
    ///
    /// - Parameter size: Size to check.
    /// - Returns: `true` if fits, `false` otherwise.
    public func fits(into size: CGSize) -> Bool {
        
        return self.width <= size.width && self.height <= size.height
    }
    
    /// + operator.
    ///
    /// - Parameters:
    ///   - left: Left operand.
    ///   - right: Right operand.
    /// - Returns: left + right.
    public static func + (left: CGSize, right: CGSize) -> CGSize {
        
        return CGSize(width: left.width + right.width, height: left.height + right.height)
    }
    
    /// - operator.
    ///
    /// - Parameters:
    ///   - left: Left operand.
    ///   - right: Right operand.
    /// - Returns: left - right.
    public static func - (left: CGSize, right: CGSize) -> CGSize {
        
        return CGSize(width: left.width - right.width, height: left.height - right.height)
    }
    
    /// * operator between CGSize and CGFloat
    ///
    /// - Parameters:
    ///   - left: CGSize
    ///   - right: CGFloat
    /// - Returns: left * right
    public static func * (left: CGSize, right: CGFloat) -> CGSize {
        
        return CGSize(width: left.width * right, height: left.height * right)
    }
    
    /// * operator between CGSize and CGFloat
    ///
    /// - Parameters:
    ///   - left: CGFloat
    ///   - right: CGSize
    /// - Returns: left * right
    public static func * (left: CGFloat, right: CGSize) -> CGSize {
        
        return CGSize(width: right.width * left, height: right.height * left)
    }
    
    /// Fits the receiver to the given size, optionally saving proportions.
    ///
    /// - Parameters:
    ///   - size: Size to fit to.
    ///   - saveProportions: Boolean value that determines whether the receiver's proportions should be saved. Default is true.
    /// - Returns: Fitted size.
    public func fit(to size: CGSize, saveProportions: Bool = true) -> CGSize {
        
        if saveProportions {
            
            let scale = min(size.width / self.width, size.height / self.height, 1.0)
            return scale * self
        }
        else {
            
            return CGSize(width: min(self.width, size.width), height: min(self.height, size.height))
        }
    }
    
    /// Interpolates CGSize value between start and finish.
    ///
    /// - Parameters:
    ///   - start: Left bound.
    ///   - finish: Right bound.
    ///   - progress: Progress in range [0, 1]
    /// - Returns: Interpolated value.
    public static func interpolate(start: CGSize, finish: CGSize, progress: CGFloat) -> CGSize {
        
        return CGSize(width: CGFloat.interpolate(start: start.width, finish: finish.width, progress: progress),
                      height: CGFloat.interpolate(start: start.height, finish: finish.height, progress: progress))
    }
}

/// Dummy struct to import CoreGraphics/CGSize module.
public struct CGSizeAdditions {
    
    @available (*, unavailable) private init() {
        
        fatalError("\(self) cannot be initialized.")
    }
}
