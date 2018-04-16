//
//  CALayer+Additions.swift
//  TapAdditionsKit
//
//  Copyright © 2018 Tap Payments. All rights reserved.
//

import struct CoreGraphics.CGBase.CGFloat
import class CoreGraphics.CGColor
import struct CoreGraphics.CGGeometry.CGRect
import class QuartzCore.CALayer
import class UIKit.UIColor
import struct UIKit.UIRectEdge

private var borderLayerLeftKey: UInt8 = 0
private var borderLayerRightKey: UInt8 = 0
private var borderLayerTopKey: UInt8 = 0
private var borderLayerBottomKey: UInt8 = 0

/// Useful extension of CALayer class.
public extension CALayer {
    
    // MARK: - Public -
    // MARK: Properties
    
    /// Returns longest animation duration of the layer.
    public var longestAnimationDuration: TimeInterval {
        
        var longestDuration = 0.0
        
        if let keys = animationKeys() {
            
            for key in keys {
                
                let animation = self.animation(forKey: key)
                let currentAnimationDuration = animation?.duration ?? 0.0
                if currentAnimationDuration > longestDuration {
                    
                    longestDuration = currentAnimationDuration
                }
            }
        }
        
        if let nonnullSublayers = self.sublayers {
            
            for sublayer in nonnullSublayers {
                
                let duration = sublayer.longestAnimationDuration
                if duration > longestDuration {
                    
                    longestDuration = duration
                }
            }
        }
        
        return longestDuration
    }
    
    // MARK: Methods
    
    /// Removes all animations.
    public func removeAnimations(includeSublayers: Bool = true) {
        
        self.removeAllAnimations()
        
        if includeSublayers {
            
            guard let nonnullSublayers = self.sublayers else { return }
            
            for sublayer in nonnullSublayers {
                
                sublayer.removeAnimations()
            }
        }
    }
    
    /**
     Sets border on a given edge.
     
     - parameter edge:  Edge mask to set border for.
     - parameter width: Border width.
     - parameter color: Border color.
     */
    public func setBorder(onEdge edge: UIRectEdge, width: CGFloat, color: CGColor?) {
        
        if edge.contains(.left) {
            
            self.leftBorderLayer?.frame = CGRect(x: 0.0, y: 0.0, width: width, height: bounds.height)
            self.leftBorderLayer?.backgroundColor = color
        }
        
        if edge.contains(.right) {
            
            self.rightBorderLayer?.frame = CGRect(x: bounds.width - width, y: 0.0, width: width, height: bounds.height)
            self.rightBorderLayer?.backgroundColor = color
        }
        
        if edge.contains(.top) {
            
            self.topBorderLayer?.frame = CGRect(x: 0.0, y: 0.0, width: bounds.width, height: width)
            self.topBorderLayer?.backgroundColor = color
        }
        
        if edge.contains(.bottom) {
            
            self.bottomBorderLayer?.frame = CGRect(x: 0.0, y: bounds.height - width, width: bounds.width, height: width)
        }
    }
    
    // MARK: - Private -
    // MARK: Properties
    
    private var leftBorderLayer: CALayer? {
        
        get {
            
            var bLayer = objc_getAssociatedObject(self, &borderLayerLeftKey) as? CALayer
            
            if bLayer == nil {
                
                bLayer = CALayer()
                bLayer!.bounds = bounds
                bLayer!.backgroundColor = UIColor.clear.cgColor
                addSublayer(bLayer!)
                
                self.leftBorderLayer = bLayer
            }
            
            return bLayer
        }
        set {
            
            objc_setAssociatedObject(self, &borderLayerLeftKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    private var rightBorderLayer: CALayer? {
        
        get {
            
            var bLayer = objc_getAssociatedObject(self, &borderLayerRightKey) as? CALayer
            
            if bLayer == nil {
                
                bLayer = CALayer()
                bLayer!.bounds = bounds
                bLayer!.backgroundColor = UIColor.clear.cgColor
                addSublayer(bLayer!)
                
                self.rightBorderLayer = bLayer
            }
            
            return bLayer
        }
        set {
            
            objc_setAssociatedObject(self, &borderLayerRightKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    private var topBorderLayer: CALayer? {
        
        get {
            
            var bLayer = objc_getAssociatedObject(self, &borderLayerTopKey) as? CALayer
            
            if bLayer == nil {
                
                bLayer = CALayer()
                bLayer!.bounds = bounds
                bLayer!.backgroundColor = UIColor.clear.cgColor
                addSublayer(bLayer!)
                
                self.topBorderLayer = bLayer
            }
            
            return bLayer
        }
        set {
            
            objc_setAssociatedObject(self, &borderLayerTopKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    private var bottomBorderLayer: CALayer? {
        
        get {
            
            var bLayer = objc_getAssociatedObject(self, &borderLayerBottomKey) as? CALayer
            
            if bLayer == nil {
                
                bLayer = CALayer()
                bLayer!.bounds = bounds
                bLayer!.backgroundColor = UIColor.clear.cgColor
                addSublayer(bLayer!)
                
                self.bottomBorderLayer = bLayer
            }
            
            return bLayer
        }
        set {
            
            objc_setAssociatedObject(self, &borderLayerBottomKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}

/// Dummy struct to import QuartzCore/CALayer module.
public struct CALayerAdditions {
    
    @available (*, unavailable) private init() {
        
        fatalError("\(self) cannot be initialized.")
    }
}
