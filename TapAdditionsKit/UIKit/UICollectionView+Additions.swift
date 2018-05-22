//
//  UICollectionView+Additions.swift
//  TapAdditionsKit
//
//  Copyright © 2018 Tap Payments. All rights reserved.
//

import struct Foundation.NSIndexPath.IndexPath
import class UIKit.UICollectionView.UICollectionView

/// Useful additions for UICollectionView.
public extension UICollectionView {
    
    // MARK: - Public -
    // MARK: Properties
    
    /// Returns selected index path if collection view is in a single selection mode.
    public var indexPathForSelectedItem: IndexPath? {
        
        guard !self.allowsMultipleSelection else { return nil }
        
        return self.indexPathsForSelectedItems?.first
    }
}

/// Dummy struct to import UIKit/UICollectionView module.
public struct UICollectionViewAdditions {
    
    @available (*, unavailable) private init() {
        
        fatalError("\(self) cannot be initialized.")
    }
}
