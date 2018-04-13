//
//  NSObject+Additions.swift
//  TapAdditionsKit
//
//  Copyright © 2018 Tap Payments. All rights reserved.
//

/// Some extensions to NSObject.
public extension NSObject {
    
    // MARK: - Public -
    // MARK: Properties
    
    /*!
     Returns class name as string.
     */
    public static var className: String {
        
        return "\(self)"
    }
    
    /// Returns class name as string.
    public var className: String {
        
        return type(of: self).className
    }
    
    // MARK: Methods
    
    /*!
     Returns the receiver as Self.
     
     - returns: Receiver as Self
     */
    public func asSelf<T>() -> T {
        
        guard let result = self as? T else {
            
            fatalError("Receiver is not convertible to Self.")
        }
        
        return result
    }
    
    /*!
     Performs given selector on main thread after delay.
     
     - parameter selector:      Selector to be called by receiver.
     - parameter object:        Object.
     - parameter delay:         Delay in seconds.
     - parameter waitUntilDone: Defines if main thread will wait for execution finishes.
     */
    public func performSelectorOnMainThread(_ aSelector: Selector, withObject object: AnyObject?, afterDelay delay: TimeInterval, waitUntilDone: Bool) {
        
        let dispatchDelay = DispatchTime.now() + delay
        
        DispatchQueue.main.asyncAfter(deadline: dispatchDelay) { [weak self] in
            
            self?.performSelector(onMainThread: aSelector, with: object, waitUntilDone: waitUntilDone)
        }
    }
}
