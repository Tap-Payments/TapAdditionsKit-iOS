//
//  KeyframeAnimationOptions+Additions.swift
//  TapAdditionsKit
//
//  Copyright © 2019 Tap Payments. All rights reserved.
//

import class	UIKit.UIView.UIView

public extension UIView.KeyframeAnimationOptions {
    
    // MARK: - Public -
    // MARK: Methods
    
    /// Initializes anima
    ///
    /// - Parameter animationOptions: Animation options.
    public init(tap_animationOptions: UIView.AnimationOptions) {
        
        self.init(rawValue: tap_animationOptions.rawValue)
    }
}
