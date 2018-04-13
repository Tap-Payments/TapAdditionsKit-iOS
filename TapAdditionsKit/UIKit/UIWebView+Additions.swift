//
//  UIWebView+Additions.swift
//  TapAdditionsKit
//
//  Copyright © 2018 Tap Payments. All rights reserved.
//

import struct CoreGraphics.CGGeometry.CGSize
import class UIKit.UIWebView.UIWebView

/// Useful extension for UIWebView
public extension UIWebView {
    
    // MARK: - Public -
    // MARK: Properties
    
    /// Defines if web view is empty.
    public var isEmpty: Bool {
        
        guard let jsResult = self.stringByEvaluatingJavaScript(from: "document.getElementsByTagName('body')[0].innerHTML") else { return true }
        
        return jsResult.length == 0
    }
    
    /// Returns web page size.
    public var contentSize: CGSize {
        
        return self.sizeThatFits(.zero)
    }
}
