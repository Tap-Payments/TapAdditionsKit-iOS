//
//  CGRect+Additions.swift
//  TapAdditionsKit
//
//  Copyright © 2018 Tap Payments. All rights reserved.
//

import struct CoreGraphics.CGBase.CGFloat
import struct CoreGraphics.CGGeometry.CGPoint
import struct CoreGraphics.CGGeometry.CGRect
import struct CoreGraphics.CGGeometry.CGSize

/// Useful additions for CGRect.
public extension CGRect {
    
    // MARK: - Public -
    // MARK: Properties
    
    /// Returns ceiled rect with integer origin and size.
    public var ceiled: CGRect {
        
        return CGRect(origin: self.origin.floored, size: self.size.ceiled)
    }
    
    /// Returns floored rect with integer origin and size.
    public var floored: CGRect {
        
        return CGRect(origin: self.origin.ceiled, size: self.size.floored)
    }
    
    /// Returns center point of CGRect.
    public var center: CGPoint {
        
        return CGPoint(x: self.midX, y: self.midY)
    }
    
    /// Returns top center point.
    public var topCenter: CGPoint {
        
        return CGPoint(x: self.midX, y: self.minY)
    }
    
    /// Returns bottom center point.
    public var bottomCenter: CGPoint {
        
        return CGPoint(x: self.midX, y: self.maxY)
    }
    
    /// Returns left center point.
    public var leftCenter: CGPoint {
        
        return CGPoint(x: self.minX, y: self.midY)
    }
    
    /// Returns right center point.
    public var rightCenter: CGPoint {
        
        return CGPoint(x: self.maxX, y: self.midY)
    }
    
    /// Returns top left point.
    public var topLeftCorner: CGPoint {
        
        return CGPoint(x: self.minX, y: self.minY)
    }
    
    /// Returns top right point.
    public var topRightCorner: CGPoint {
        
        return CGPoint(x: self.maxX, y: self.minY)
    }
    
    /// Returns bottom left point.
    public var bottomLeftCorner: CGPoint {
        
        return CGPoint(x: self.minX, y: self.maxY)
    }
    
    /// Returns bottom right point.
    public var bottomRightCorner: CGPoint {
        
        return CGPoint(x: self.maxX, y: self.maxY)
    }
    
    /// Returns a rect replacing all NaNs with 0.0.
    public var withoutNans: CGRect {
        
        return CGRect(x: self.origin.x.isNaN ? 0.0 : self.origin.x,
                      y: self.origin.y.isNaN ? 0.0 : self.origin.y,
                      width: self.width.isNaN ? 0.0 : self.width,
                      height: self.height.isNaN ? 0.0 : self.height)
    }
    
    // MARK: Methods
    
    /// Returns receiver clipped with a given rect.
    ///
    /// - Parameter rect: Clipping rect.
    /// - Returns: Receiver clipped with a given rect.
    public func clip(with rect: CGRect) -> CGRect {
        
        guard self.intersects(rect) else { return CGRect.zero }
        
        return self.intersection(rect)
    }
    
    /// Returns resized copy of the receiver within the same origin.
    ///
    /// - Parameter delta: Delta size.
    /// - Returns: CGRect(origin, size + delta)
    public func resized(by delta: CGSize) -> CGRect {
        
        return CGRect(origin: self.origin, size: self.size + delta)
    }
    
    /// Returns scaled copy of the receiver.
    ///
    /// - Parameter scaleFactor: Scale factor.
    /// - Returns: CGRect(origin * scaleFactor, size * scaleFactor)
    public func scaled(by scaleFactor: CGFloat) -> CGRect {
        
        return CGRect(origin: self.origin * scaleFactor, size: self.size * scaleFactor)
    }
    
    /// Returns moved copy of the receiver.
    ///
    /// - Parameter offset: Offset.
    /// - Returns: CGRect(origin + offset, size)
    public func moved(by offset: CGPoint) -> CGRect {
        
        return CGRect(origin: self.origin + offset, size: self.size)
    }
}
