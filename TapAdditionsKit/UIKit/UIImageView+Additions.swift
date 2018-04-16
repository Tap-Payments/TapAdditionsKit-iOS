//
//  UIImageView+Additions.swift
//  TapAdditionsKit
//
//  Copyright © 2018 Tap Payments. All rights reserved.
//

import class UIKit.UIImage.UIImage
import class UIKit.UIImageView.UIImageView
import class UIKit.UIView.UIView
import struct UIKit.UIView.UIViewAnimationOptions

/// Useful extension to UIImageView class.
public extension UIImageView {
    
    // MARK: - Public -
    // MARK: Methods
    
    /// Stretches the image.
    public func stretchImage() {
        
        self.image = self.image?.stretchableImage
        self.highlightedImage = self.highlightedImage?.stretchableImage
    }
    
    /// Sets image with animation.
    ///
    /// - Parameters:
    ///   - image: Image to set.
    ///   - duration: Animation duration.
    public func setImageAnimated(_ image: UIImage?, duration: TimeInterval) {
        
        let fadingImageView = UIImageView(frame: bounds)
        fadingImageView.contentMode = contentMode
        fadingImageView.image = image
        fadingImageView.alpha = 0.0
        
        self.addSubviewWithConstraints(fadingImageView)
        
        let options: UIViewAnimationOptions = [.curveEaseInOut, .beginFromCurrentState, .overrideInheritedDuration, .allowAnimatedContent]
        let animation = {
            
            fadingImageView.alpha = 1.0
        }
        
        UIView.animate(withDuration: duration, delay: 0.0, options: options, animations: animation) { [weak self] (_) in
            
            self?.image = image
            fadingImageView.image = nil
            fadingImageView.removeFromSuperview()
        }
    }
}

/// Dummy struct to import UIKit/UIImageView module.
public struct UIImageViewAdditions {
    
    @available (*, unavailable) private init() {
        
        fatalError("\(self) cannot be initialized.")
    }
}
