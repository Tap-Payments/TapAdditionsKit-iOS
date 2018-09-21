//
//  AnimationOptions+Additions.swift
//  TapAdditionsKit
//
//  Copyright © 2018 Tap Payments. All rights reserved.
//

import class UIKit.UIView.UIView

public extension UIView.AnimationOptions {
    
    // MARK: - Public -
    // MARK: Methods
    
    public init(_ curve: UIView.AnimationCurve) {
        
        switch curve {
            
        case .easeIn:       self = .curveEaseIn
        case .easeOut:      self = .curveEaseOut
        case .easeInOut:    self = .curveEaseInOut
        case .linear:       self = .curveLinear
            
        }
    }
}
