//
//  UILabel+Additions.swift
//  TapAdditionsKit
//
//  Copyright © 2018 Tap Payments. All rights reserved.
//

import class UIKit.UIColor.UIColor
import class UIKit.UILabel.UILabel
import class UIKit.UIView.UIView

/// Useful extensions to UILabel class.
public extension UILabel {
    
    // MARK: - Public -
    // MARK: Methods
    
    /// Sets text color with animation.
    ///
    /// - Parameters:
    ///   - textColor: Text color.
    ///   - animationDuration: Animation duration.
    public func setTextColor(_ textColor: UIColor, animationDuration: TimeInterval) {
        
        let animations: TypeAlias.ArgumentlessClosure = { [weak self] in
            
            self?.textColor = textColor
        }
        
        UIView.transition(with: self, duration: max(animationDuration, 0.0), options: .transitionCrossDissolve, animations: animations, completion: nil)
    }
    
    /// Sets text with animation.
    ///
    /// - Parameters:
    ///   - text: string for text
    ///   - animationDuration: Animation duration
    public func setText(_ text: String, animationDuration: TimeInterval) {
        
        let animations: TypeAlias.ArgumentlessClosure = { [weak self] in
            
            self?.text = text
        }
        
        UIView.transition(with: self, duration: max(animationDuration, 0.0), options: [.transitionCrossDissolve, .layoutSubviews], animations: animations, completion: nil)
    }
}
