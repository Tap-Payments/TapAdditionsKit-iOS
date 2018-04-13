//
//  UIDevice+Additions.swift
//  TapAdditionsKit
//
//  Copyright © 2018 Tap Payments. All rights reserved.
//

import class UIKit.UIDevice

/// Useful extension for UIDevice.
public extension UIDevice {
    
    // MARK: - Public -
    // MARK: Properties
    
    /// Returns OS version.
    public var operatingSystemVersion: OperatingSystemVersion {
        
        return ProcessInfo.processInfo.operatingSystemVersion
    }
    
    /// Defines if device is running iOS 8 or lower
    public var isRunningIOS9OrLower: Bool {
        
        return self.operatingSystemVersion.majorVersion < 10
    }
    
    /// Defines if device is running iOS 9 or lower
    public var isRunningIOS8OrLower: Bool {
        
        return self.operatingSystemVersion.majorVersion < 9
    }
    
    /// Defines if app is running on simulator.
    public var isSimulator: Bool {
        
        #if targetEnvironment(simulator)
            
            return true
            
        #else
            
            return false
            
        #endif
    }
    
    /// Defines if device is 64-bit.
    public var is64Bit: Bool {
        
        #if __LP64__
            
            return true
            
        #else
            
            return false
            
        #endif
    }
    
    /// Defines if device is iPad
    public var isIPad: Bool {
        
        return self.userInterfaceIdiom == .pad
    }
}
