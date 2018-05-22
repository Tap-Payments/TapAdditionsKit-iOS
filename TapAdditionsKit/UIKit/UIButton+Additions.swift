//
//  UIButton+Additions.swift
//  TapAdditionsKit
//
//  Copyright © 2018 Tap Payments. All rights reserved.
//

import class Foundation.NSAttributedString.NSAttributedString
import class UIKit.UIButton.UIButton
import class UIKit.UIColor.UIColor
import struct UIKit.UIControl.UIControlState
import class UIKit.UIImage.UIImage

/// Useful extension for UIButton.
public extension UIButton {
    
    // MARK: - Public -
    // MARK: Properties
    
    /// Title.
    public var title: String? {
        
        get {
            
            return self.title(for: .normal)
        }
        set {
            
            self.setTitle(newValue, for: .disabled)
            self.setTitle(newValue, for: .normal)
            self.setTitle(newValue, for: .highlighted)
            self.setTitle(newValue, for: .selected)
            self.setTitle(newValue, for: [.selected, .highlighted])
        }
    }
    
    /// Attributed title.
    public var attributedTitle: NSAttributedString? {
        
        get {
            
            return self.attributedTitle(for: .normal)
        }
        set {
            
            self.setAttributedTitle(newValue, for: .disabled)
            self.setAttributedTitle(newValue, for: .normal)
            self.setAttributedTitle(newValue, for: .highlighted)
            self.setAttributedTitle(newValue, for: .selected)
            self.setAttributedTitle(newValue, for: [.selected, .highlighted])
        }
    }
    
    /// Title color.
    public var titleColor: UIColor? {
        
        get {
            
            return self.titleColor(for: .normal)
        }
        set {
            
            self.setTitleColor(newValue, for: .disabled)
            self.setTitleColor(newValue, for: .normal)
            self.setTitleColor(newValue, for: .highlighted)
            self.setTitleColor(newValue, for: .selected)
            self.setTitleColor(newValue, for: [.selected, .highlighted])
        }
    }
    
    // MARK: Methods
    
    /// Applies background image with optional stretch.
    ///
    /// - Parameters:
    ///   - image: Background image.
    ///   - state: Button state.
    ///   - stretch: Stretch parameter.
    public func setBackgroundImage(_ image: UIImage?, for state: UIControlState, withStretch stretch: Bool) {
        
        let backgroundImage = stretch ? image?.stretchableImage : image
        self.setBackgroundImage(backgroundImage, for: state)
    }
    
    /// Stretche background image for a given state.
    ///
    /// - Parameter state: Button state.
    public func stretchBackgroundImage(for state: UIControlState) {
        
        if let backgroundImage = self.backgroundImage(for: state) {
            
            self.setBackgroundImage(backgroundImage, for: state, withStretch: true)
        }
    }
    
    /// Stretches background image for all states.
    public func stretchBackgroundImage() {
        
        self.stretchBackgroundImage(for: .disabled)
        self.stretchBackgroundImage(for: .normal)
        self.stretchBackgroundImage(for: .highlighted)
        self.stretchBackgroundImage(for: .selected)
        self.stretchBackgroundImage(for: [.selected, .highlighted])
    }
}

/// Dummy struct to import UIKit/UIButton module.
public struct UIButtonAdditions {
    
    @available (*, unavailable) private init() {
        
        fatalError("\(self) cannot be initialized.")
    }
}
