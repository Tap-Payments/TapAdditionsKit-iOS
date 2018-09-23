//
//  UIView+Additions.swift
//  TapAdditionsKit
//
//  Copyright © 2018 Tap Payments. All rights reserved.
//

import struct   CoreGraphics.CGAffineTransform
import struct   CoreGraphics.CGBase.CGFloat
import func     CoreGraphics.CGBase.pow
import struct   CoreGraphics.CGGeometry.CGPoint
import struct   CoreGraphics.CGGeometry.CGRect
import struct   CoreGraphics.CGGeometry.CGSize
import func     Darwin.sqrt
import class    Foundation.NSBundle.Bundle
import struct   Foundation.NSDate.TimeInterval
import class    QuartzCore.CAShapeLayer.CAShapeLayer
import class    UIKit.NSLayoutConstraint
import class    UIKit.UIBezierPath.UIBezierPath
import struct   UIKit.UIBezierPath.UIRectCorner
import class    UIKit.UIColor
import func     UIKit.UIGraphicsBeginImageContextWithOptions
import func     UIKit.UIGraphicsEndImageContext
import func     UIKit.UIGraphicsGetCurrentContext
import func     UIKit.UIGraphicsGetImageFromCurrentImageContext
import class    UIKit.UIImage
import class    UIKit.UIResponder
import class    UIKit.UIScreen
import class    UIKit.UIScrollView
import enum     UIKit.UISemanticContentAttribute
import class    UIKit.UIView

/// Useful extension to UIView.
@IBDesignable extension UIView {
    
    // MARK: - Public -
    // MARK: Properties
    
    /// Corner radius of the view.
    @IBInspectable public var cornerRadius: CGFloat {
        
        get {
            
            return self.layer.cornerRadius
        }
        set {
            
            self.layer.cornerRadius = newValue
        }
    }
    
    /// Border width of the view.
    @IBInspectable public var borderWidth: CGFloat {
        
        get {
            
            return self.layer.borderWidth
        }
        set {
            
            self.layer.borderWidth = newValue
        }
    }
    
    /// Border color of the view.
    @IBInspectable public var borderColor: UIColor? {
        
        get {
            guard let cgBorderColor = self.layer.borderColor else {
                
                return nil
            }
            
            return UIColor(cgColor: cgBorderColor)
        }
        set {
            
            self.layer.borderColor = newValue?.cgColor
        }
    }
    
    /// Horizontal scale of the view.
    @IBInspectable public var horizontalScale: CGFloat {
        
        get {
            
            let transform = self.layer.affineTransform()
            return sqrt(pow(transform.a, 2.0) + pow(transform.c, 2.0))
        }
        set {
            
            self.layer.setAffineTransform(CGAffineTransform(scaleX: newValue, y: self.verticalScale))
        }
    }
    
    /// Vertical scale of the view.
    @IBInspectable public var verticalScale: CGFloat {
        
        get {
            
            let transform = self.layer.affineTransform()
            return sqrt(pow(transform.b, 2.0) + pow(transform.d, 2.0))
        }
        set {
            
            self.layer.setAffineTransform(CGAffineTransform(scaleX: self.horizontalScale, y: newValue))
        }
    }
    
    /// Inspectable translatesAutoresizingMaskIntoConstraints
    @IBInspectable public var convertsAutoresizingMaskIntoConstraints: Bool {
        
        get {
            
            return self.translatesAutoresizingMaskIntoConstraints
        }
        set {
            
            self.translatesAutoresizingMaskIntoConstraints = newValue
        }
    }
    
    /// Returns screenshot of the view.
    public var screenshot: UIImage? {
        
        return self.screenshot(with: 1.0)
    }
    
    /// Returns current first responder in a view hieararchy with receiver as a parent or nil if there is no first responder set.
    public var firstResponder: UIResponder? {
        
        if self.isFirstResponder {
            
            return self
        }
        
        for subview in self.subviews {
            
            if let fResponder = subview.firstResponder {
                
                return fResponder
            }
        }
        
        return nil
    }
    
    /// Defines if the receiver contains subview that is scrolling.
    public var containsScrollingScrollView: Bool {
        
        if let scrollView = self as? UIScrollView {
            
            if scrollView.isDecelerating || scrollView.isDragging || scrollView.isTracking {
                
                return true
            }
        }
        
        return self.subviews.filter { $0.containsScrollingScrollView }.count > 0
    }
    
    /// Returns existing width constraint if presented or creates new one, attaches it to the view and returns.
    public var widthConstraint: NSLayoutConstraint {
        
        if let wConstraint = self.widthConstraintIfPresent {
            
            return wConstraint
        }
        
        let constraint = NSLayoutConstraint(item: self, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: self.bounds.width)
        self.addConstraint(constraint)
        
        return constraint
    }
    
    /// Returns width layout constraint if it is presented.
    public var widthConstraintIfPresent: NSLayoutConstraint? {
        
        return self.constraints.filter { $0.firstAttribute == .width }.first
    }
    
    /// Returns existing height constraint if presented or creates new one, attaches it to the view and returns.
    public var heightConstraint: NSLayoutConstraint {
        
        if let hConstraint = self.heightConstraintIfPresent {
            
            return hConstraint
        }
        
        let constraint = NSLayoutConstraint(item: self, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: self.bounds.height)
        self.addConstraint(constraint)
        
        return constraint
    }
    
    /// Returns height layout constraint if it is presented.
    public var heightConstraintIfPresent: NSLayoutConstraint? {
        
        return self.constraints.filter { $0.firstAttribute == .height }.first
    }
    
    // MARK: Methods
    
    /**
     Loads view from a given nib file.
     
     - parameter nibName: Nib name.
     
     - returns: Top view in the hieararchy of the given nib file or nil if error occured during view creation.
     */
    public func load<T>(from nibName: String?) -> T? {
        
        guard let nonnullNibName = nibName, !nonnullNibName.isEmpty else { return nil }
        
        guard let views = Bundle.main.loadNibNamed(nonnullNibName, owner: nil, options: nil) else { return nil }
        
        let selfViews = views.compactMap { return $0 as? T }
        return selfViews.first
    }
    
    /**
     Returns color of a given point.
     
     - parameter point: Point.
     
     - returns: Color of a given point or nil if point is outside the view.
     */
    open func color(at point: CGPoint) -> UIColor? {
        
        if !self.bounds.contains(point) {
            
            return nil
        }
        
        let pixelSize = UIScreen.main.numberOfPointsInOnePixel
        
        let screenshot = self.screenshot(area: CGRect(origin: point, size: CGSize(width: pixelSize, height: pixelSize)))
        return screenshot?.color(at: CGPoint.zero)
    }
    
    /**
     Removes all animations on a given view and all subviews.
     */
    public func removeAllAnimations() {
        
        self.removeAllAnimations(includeSubviews: true)
    }
    
    public func removeAllAnimations(includeSubviews: Bool) {
        
        self.layer.removeAnimations()
        
        if includeSubviews {
            
            for subview in self.subviews {
                
                subview.removeAllAnimations()
            }
        }
    }
    
    /**
     Enables/disables exclusive touch on all subviews.
     
     - parameter touch: Boolean parameter to determine whether exclusive touch should be enabled.
     */
    public func setExclusiveTouchOnAllSubviews(_ touch: Bool) {
        
        self.isExclusiveTouch = touch
        for subview in subviews {
            
            subview.setExclusiveTouchOnAllSubviews(touch)
        }
    }
    
    /**
     Sets up scale.
     
     - parameter scale: Scale to set.
     */
    public func setScale(_ scale: CGFloat) {
        
        self.layer.setAffineTransform(CGAffineTransform(scaleX: scale, y: scale))
    }
    
    /// Sets translates autoresizing masks into constraints on all subviews.
    ///
    /// - Parameters:
    ///   - value: Boolean value to apply.
    ///   - includeSubviews: Defines if the value should be applied for the subviews ( and their subviews ).
    public func setTranslatesAutoresizingMasksIntoConstrants(_ value: Bool, includeSubviews: Bool = true) {
        
        self.translatesAutoresizingMaskIntoConstraints = value
        
        if includeSubviews {
            
            for subview in self.subviews {
                
                subview.setTranslatesAutoresizingMasksIntoConstrants(value, includeSubviews: true)
            }
        }
    }
    
    /**
     Returns first subview of specific class.
     
     - parameter subviewClass: Class of the subview.
     
     - returns: First subview of specific class if nil if subview could not be found.
     */
    public func subview<T>(ofClass subviewClass: T.Type) -> T? where T: AnyObject {
        
        for subview in self.subviews {
            
            if subview.isKind(of: subviewClass) {
                
                return subview as? T
            }
            
            if let requiredSubview = subview.subview(ofClass: subviewClass) {
                
                return requiredSubview
            }
        }
        
        return nil
    }
    
    /// Applies semantic content attribute for the receiver and all subviews.
    ///
    /// - Parameter attribute: Attribute to apply.
    @available(iOS 9.0, *) open func applySemanticContentAttribute(_ attribute: UISemanticContentAttribute) {
        
        self.semanticContentAttribute = attribute
        
        for subview in self.subviews {
            
            subview.applySemanticContentAttribute(self.semanticContentAttribute)
        }
    }
    
    /**
     Adds subview with constraints.
     
     - parameter subview:  Subview to add.
     */
    public func addSubviewWithConstraints(_ subview: UIView, respectLanguageDirection: Bool = true) {
        
        subview.frame = self.bounds
        
        self.addSubview(subview)
        self.addConstraints(to: subview, respectLanguageDirection: respectLanguageDirection)
    }
    
    /**
     Adds constraints to a specific subview.
     
     - parameter subview: Subview to add constraints to.
     */
    public func addConstraints(to subview: UIView, respectLanguageDirection: Bool) {
        
        subview.translatesAutoresizingMaskIntoConstraints = false
        
        let views = ["subview": subview]
        
        let layoutFormatOptions: NSLayoutConstraint.FormatOptions = respectLanguageDirection ? .directionLeadingToTrailing : .directionLeftToRight
        
        var newConstraints: [NSLayoutConstraint] = []
        newConstraints.append(contentsOf: NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[subview]-0-|", options: layoutFormatOptions, metrics: nil, views: views))
        newConstraints.append(contentsOf: NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[subview]-0-|", options: layoutFormatOptions, metrics: nil, views: views))
        
        newConstraints.forEach { $0.isActive = true }
    }
    
    /**
     Removes from superview with fade out animation.
     */
    public func removeFromSuperviewAnimated() {
        
        self.removeFromSuperviewAnimated(with: Constants.defaultRemoveFromSuperviewAnimationDuration)
    }
    
    /// Removes from superview with fade out animation.
    ///
    /// - Parameter duration: Animation duration.
    public func removeFromSuperviewAnimated(with duration: TimeInterval) {
        
        let animations = {
            
            self.alpha = 0.0
        }
        
        let completion: TypeAlias.BooleanClosure = { _ in
            
            self.removeFromSuperview()
        }
        
        UIView.animate(withDuration: duration, animations: animations, completion: completion)
    }
    
    /// Returns a screenshot with a specific resulting image scale.
    ///
    /// - Parameter scale: Resulting image scale.
    /// - Returns: Screenshot image.
    public func screenshot(with scale: CGFloat) -> UIImage? {
        
        return self.screenshot(area: self.bounds, with: scale)
    }
    
    /// Returns a screenshot of specific area with specific resulting image scale.
    ///
    /// - Parameters:
    ///   - area: Area to screenshot measured in points.
    ///   - scale: Resulting image scale.
    /// - Returns: Screenshot image.
    public func screenshot(area: CGRect, with scale: CGFloat = 1.0) -> UIImage? {
        
        let imageScale = scale / UIScreen.main.numberOfPointsInOnePixel
        
        UIGraphicsBeginImageContextWithOptions(area.size, false, imageScale)
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        
        context.translateBy(x: -area.origin.x, y: -area.origin.y)
        
        context.clear(bounds)
        context.setFillColor(UIColor.clear.cgColor)
        
        self.drawHierarchy(in: bounds, afterScreenUpdates: true)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        return image
    }
    
    /// Force layout.
    public func layout() {
        
        self.setNeedsLayout()
        self.layoutIfNeeded()
    }
    
    /// Changes receiver's frame to fit its superview.
    public func stickToSuperview() {
        
        if let nonnullSuperview = self.superview {
            
            var viewFrame = self.frame
            viewFrame.origin.y = 0.0
            viewFrame.size = nonnullSuperview.bounds.size
            
            if self.frame != viewFrame {
                
                self.frame = viewFrame
            }
        }
    }
    
    /// 'Rounds' specific corners of the receiver with the specified corner radius.
    ///  Important: Calling this method will replace existing masks on the layer (if presented).
    ///
    /// - Parameters:
    ///   - corners: Corners to round.
    ///   - radius: Corner radius.
    public func roundCorners(_ corners: UIRectCorner, with radius: CGFloat) {
        
        let radii = CGSize(width: radius, height: radius)
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: radii)
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        self.layer.mask = shapeLayer
    }
    
    // MARK: - Private -
    
    private struct Constants {
        
        fileprivate static let defaultRemoveFromSuperviewAnimationDuration: TimeInterval = 0.35
        
        @available(*, unavailable) private init() {}
    }
}

/// Dummy struct to import UIKit/UIView module.
public struct UIViewAdditions {
    
    @available (*, unavailable) private init() {
        
        fatalError("\(self) cannot be initialized.")
    }
}
