//
//  UIResponder+Additions.swift
//  TapAdditionsKit
//
//  Copyright © 2018 Tap Payments. All rights reserved.
//

import class    QuartzCore.CATransaction.CATransaction
import class    UIKit.UIApplication.UIApplication
import class    UIKit.UIResponder.UIResponder
import class    UIKit.UIView.UIView

/// Useful additions to UIResponder.
public extension UIResponder {
    
    // MARK: - Public -
    // MARK: Properties
    
    /// Returns current first responder.
    public static var current: UIResponder? {
        
        self.currentFirstResponder = nil
        UIApplication.shared.sendAction(#selector(findFirstResponder), to: nil, from: nil, for: nil)
        
        return self.currentFirstResponder
    }
    
    // MARK: Methods
    
    public func resignFirstResponder(_ completion: @escaping TypeAlias.ArgumentlessClosure) {
        
        CATransaction.begin()
        CATransaction.setCompletionBlock(completion)
        
        self.resignFirstResponder()
        
        CATransaction.commit()
    }
    
    public static func resign(_ completion: TypeAlias.ArgumentlessClosure? = nil) {
        
        let localCompletion: TypeAlias.ArgumentlessClosure = {
            
            completion?()
        }
        
        if let responder = self.current {
            
            responder.resignFirstResponder(localCompletion)
        }
        else {
            
            localCompletion()
        }
    }
    
    // MARK: - Private -
    // MARK: Properties
    
    private static weak var currentFirstResponder: UIResponder?
    
    // MARK: Methods
    
    @objc private func findFirstResponder() {
        
        if let view = self as? UIView {
            
            UIResponder.currentFirstResponder = view.firstResponder
        }
        else {
            
            UIResponder.currentFirstResponder = self
        }
    }
}

/// Dummy struct to import UIKit/UIResponder module.
public struct UIResponderAdditions {
    
    @available (*, unavailable) private init() {
        
        fatalError("\(self) cannot be initialized.")
    }
}
