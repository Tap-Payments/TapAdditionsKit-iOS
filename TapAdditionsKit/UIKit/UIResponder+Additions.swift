//
//  UIResponder+Additions.swift
//  TapAdditionsKit
//
//  Copyright © 2018 Tap Payments. All rights reserved.
//

import class QuartzCore.CATransaction.CATransaction
import class UIKit.UIResponder.UIResponder

/// Useful additions to UIResponder.
public extension UIResponder {
    
    // MARK: Methods
    
    public func resignFirstResponder(_ completion: @escaping TypeAlias.ArgumentlessClosure) {
        
        CATransaction.begin()
        CATransaction.setCompletionBlock(completion)
        
        self.resignFirstResponder()
        
        CATransaction.commit()
    }
}

/// Dummy struct to import UIKit/UIResponder module.
public struct UIResponderAdditions {
    
    @available (*, unavailable) private init() {
        
        fatalError("\(self) cannot be initialized.")
    }
}
