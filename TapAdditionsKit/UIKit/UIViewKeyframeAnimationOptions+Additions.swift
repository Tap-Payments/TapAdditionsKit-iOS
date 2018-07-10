//
//  UIViewKeyframeAnimationOptions+Additions.swift
//  TapAdditionsKit
//
//  Copyright © 2018 Tap Payments. All rights reserved.
//

import struct   UIKit.UIView.UIViewAnimationOptions
import struct   UIKit.UIView.UIViewKeyframeAnimationOptions

public extension UIViewKeyframeAnimationOptions {
    
    // MARK: - Public -
    // MARK: Methods
    
    /// Initializes anima
    ///
    /// - Parameter animationOptions: Animation options.
    public init(_ animationOptions: UIViewAnimationOptions) {
        
        self.init(rawValue: animationOptions.rawValue)
    }
}
