//
//  UITableView+Additions.swift
//  TapAdditionsKit
//
//  Copyright © 2018 Tap Payments. All rights reserved.
//

import func TapSwiftFixes.ExceptionCatcher.catchException
import class UIKit.UITableView.UITableView
import enum UIKit.UITableView.UITableViewRowAnimation

/// Useful extension for UITableView
public extension UITableView {
    
    // MARK: - Public -
    // MARK: Methods
    
    /// Reloads visible cells.
    ///
    /// - Parameter animation: Row animation.
    public func reloadVisibleCells(with animation: UITableViewRowAnimation = .none) {
        
        guard let indexPaths = self.indexPathsForVisibleRows, indexPaths.count > 0 else { return }
        
        let closure = {
            
            self.reloadRows(at: indexPaths, with: animation)
        }
        
        var error: NSError?
        
        catchException(closure, &error)
        
        if error != nil {
            
            self.reloadData()
        }
        
        if animation == .none {
            
            self.removeAllAnimations()
        }
    }
}

/// Dummy struct to import UIKit/UITableView module.
public struct UITableViewAdditions {
    
    @available (*, unavailable) private init() {
        
        fatalError("\(self) cannot be initialized.")
    }
}
