//
//  UIViewAnimationOptions+Additions.swift
//  TapAdditionsKit
//
//  Copyright © 2018 Tap Payments. All rights reserved.
//

import enum     UIKit.UIView.UIViewAnimationCurve
import struct   UIKit.UIView.UIViewAnimationOptions

public extension UIViewAnimationOptions {
    
    // MARK: - Public -
    // MARK: Methods
    
    public init(_ curve: UIViewAnimationCurve) {
        
        switch curve {
            
        case .easeIn:       self = .curveEaseIn
        case .easeOut:      self = .curveEaseOut
        case .easeInOut:    self = .curveEaseInOut
        case .linear:       self = .curveLinear
            
        }
    }
}
