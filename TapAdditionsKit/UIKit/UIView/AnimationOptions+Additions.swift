//
//  AnimationOptions+Additions.swift
//  TapAdditionsKit
//
//  Copyright © 2019 Tap Payments. All rights reserved.
//

import class	UIKit.UIView.UIView

public extension UIView.AnimationOptions {
    
    // MARK: - Public -
    // MARK: Methods
    
    public init(tap_curve: UIView.AnimationCurve) {
        
        switch tap_curve {
            
        case .easeIn:       self = .curveEaseIn
        case .easeOut:      self = .curveEaseOut
        case .easeInOut:    self = .curveEaseInOut
        case .linear:       self = .curveLinear
            
        }
    }
}
