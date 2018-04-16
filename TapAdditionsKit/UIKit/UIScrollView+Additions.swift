//
//  UIScrollView+Additions.swift
//  TapAdditionsKit
//
//  Copyright © 2018 Tap Payments. All rights reserved.
//

import struct CoreGraphics.CGBase.CGFloat
import struct CoreGraphics.CGGeometry.CGPoint
import class UIKit.UIScrollView

/// Useful extension for UIScrollView.
public extension UIScrollView {
    
    // MARK: - Public -
    // MARK: Properties
    
    /// Returns number of pages.
    public var numberOfPages: Int {
        
        guard self.canPagingPropertiesBeCalculated else {
            
            fatalError("In order to use the function paging should be enabled and width of the scroll view should be > 0.")
        }
        
        return Int(self.contentSize.width / self.bounds.width)
    }

    /// Returns current page index.
    public var pageIndex: Int {
        
        return Int(self.floatingPageIndex)
    }
    
    /// Returns most visible page index.
    public var closestPageIndex: Int {
        
        return Int(self.floatingPageIndex.rounded())
    }
    
    /// Returns floating point page index.
    public var floatingPageIndex: CGFloat {
        
        guard self.canPagingPropertiesBeCalculated else {
            
            fatalError("In order to use the function paging should be enabled and width of the scroll view should be > 0.")
        }
        
        return clamp(value: self.contentOffset.x / self.bounds.width, low: 0.0, high: max(CGFloat(self.numberOfPages) - 1.0, 0.0))
    }
    
    /// Returns maximal content offset.
    public var maximalContentOffset: CGPoint {
        
        return CGPoint(x: max(self.contentSize.width - self.bounds.width + self.contentInset.right, -self.contentInset.left),
                       y: max(self.contentSize.height - self.bounds.height + self.contentInset.bottom, -self.contentInset.top))
    }
    
    // MARK: Methods
    
    /// Scrolls to top.
    ///
    /// - Parameter animated: Defines if scrolling should happen with animation.
    public func scrollToTop(animated: Bool) {
        
        self.setContentOffset(CGPoint(x: contentOffset.x, y: -self.contentInset.top), animated: animated)
    }
    
    /// Scrolls to bottom.
    ///
    /// - Parameter animated: Defines if scrolling should happen with animation.
    public func scrollToBottom(animated: Bool) {
        
        self.setContentOffset(CGPoint(x: contentOffset.x, y: self.maximalContentOffset.y), animated: animated)
    }
    
    /// Scrolls to left.
    ///
    /// - Parameter animated: Defines if scrolling should happen with animation.
    public func scrollToLeft(animated: Bool) {
        
        self.setContentOffset(CGPoint(x: 0.0, y: contentOffset.y), animated: animated)
    }
    
    /// Scrolls to right.
    ///
    /// - Parameter animated: Defines if scrolling should happen with animation.
    public func scrollToRight(animated: Bool) {
        
        self.setContentOffset(CGPoint(x: self.maximalContentOffset.x, y: contentOffset.y), animated: animated)
    }
    
    /// Sets content offset with optional calling delegate.
    ///
    /// - Parameters:
    ///   - offset: Desired content offset.
    ///   - callDelegate: Defines if delegate should be called.
    public func setContentOffset(_ offset: CGPoint, callDelegate: Bool) {
        
        if callDelegate {
            
            self.contentOffset = offset
        }
        else {
            
            var bounds = self.bounds
            bounds.origin = offset
            self.bounds = bounds
        }
    }
    
    // MARK: - Private -
    // MARK: Properties
    
    private var canPagingPropertiesBeCalculated: Bool {
        
        return self.isPagingEnabled && self.bounds.width > 0.0
    }
}

/// Dummy struct to import UIKit/UIScrollView module.
public struct UIScrollViewAdditions {
    
    @available (*, unavailable) private init() {
        
        fatalError("\(self) cannot be initialized.")
    }
}
