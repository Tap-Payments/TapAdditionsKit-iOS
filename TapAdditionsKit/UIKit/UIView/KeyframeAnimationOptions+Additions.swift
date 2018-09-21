//
//  KeyframeAnimationOptions+Additions.swift
//  TapAdditionsKit
//
//  Copyright © 2018 Tap Payments. All rights reserved.
//

import class UIKit.UIView.UIView

public extension UIView.KeyframeAnimationOptions {
    
    // MARK: - Public -
    // MARK: Methods
    
    /// Initializes anima
    ///
    /// - Parameter animationOptions: Animation options.
    public init(_ animationOptions: UIView.AnimationOptions) {
        
        self.init(rawValue: animationOptions.rawValue)
    }
}
