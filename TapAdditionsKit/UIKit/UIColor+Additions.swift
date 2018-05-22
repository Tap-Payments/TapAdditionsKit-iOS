//
//  UIColor+Additions.swift
//  TapAdditionsKit
//
//  Copyright © 2018 Tap Payments. All rights reserved.
//

import struct CoreGraphics.CGBase.CGFloat
import struct Foundation.NSRange.NSRange
import class Foundation.NSScanner.Scanner
import struct OpenGLES.gltypes.GLfloat
import class UIKit.UIColor.UIColor

/// UIColor extension.
public extension UIColor {
    
    // MARK: - Public -
    // MARK: Properties
    
    /*!
     Creates and returns extra light native blur tint color.
     
     - returns: Extra light native blur tint color.
     */
    public static let extraLightBlurTintColor = UIColor(white: 0.97, alpha: 0.82)
    
    /*!
     Creates and returns light native blur tint color.
     
     - returns: Light native blur tint color.
     */
    public static let lightBlurTintColor: UIColor = UIColor(white: 1.0, alpha: 0.3)
    
    /*!
     Creates and returns dark native blur tint color.
     
     - returns: Dark native blur tint color.
     */
    public static let darkBlurTintColor = UIColor(white: 0.11, alpha: 0.73)
    
    /// Returns gl components of the color.
    public var glComponents: [GLfloat]? {
        
        guard let nonnullRGBAComponents = self.rgbaComponents else { return nil }
        
        var result: [GLfloat] = []
        for component in nonnullRGBAComponents {
            
            result.append(GLfloat(component))
        }
        
        return result
    }
    
    /// Returns RGBA color components.
    public var rgbaComponents: [CGFloat]? {
        
        var red: CGFloat = 0.0
        var green: CGFloat = 0.0
        var blue: CGFloat = 0.0
        var alpha: CGFloat = 0.0
        
        if self.getRed(&red, green: &green, blue: &blue, alpha: &alpha) {
            
            return [red, green, blue, alpha]
        }
        else if self.getWhite(&red, alpha: &alpha) {
            
            return [red, red, red, alpha]
        }
        else {
            
            return nil
        }
    }
    
    // MARK: Methods
    
    /// Initializes color with RGBA components.
    ///
    /// - Parameter rgba: RGBA components.
    public convenience init?(rgba: [CGFloat]) {
        
        let componentsCount = rgba.count
        
        switch componentsCount {
            
        case 2:
            
            self.init(white: rgba[0], alpha: rgba[1])
            
        case 3:
            
            self.init(red: rgba[0], green: rgba[1], blue: rgba[2], alpha: 1.0)
            
        case 4:
            
            self.init(red: rgba[0], green: rgba[1], blue: rgba[2], alpha: rgba[3])
            
        default:
            
            print("Number of components should be 2, 3 or 4.")
            return nil
        }
    }
    
    /*!
     Fabric that initializes and returns UIColor from its hex representation
     
     - parameter hexString: HEX representation of a color.
     
     - returns: UIColor or nil if HEX string is incorrect.
     */
    public static func withHex(_ hexString: String) -> UIColor? {
        
        return UIColor(hex: hexString)
    }
    
    /*!
     Initializes UIColor from its hex representation
     
     - parameter hexString: HEX representation of a color.
     
     - returns: UIColor or nil if HEX string is incorrect.
     */
    public convenience init?(hex hexString: String) {
        
        let stringToScan = (hexString.hasPrefix(Constants.hexPrefix) ? String(hexString.suffix(from: Constants.hexPrefix.length.index(in: hexString))) : hexString).uppercased()
        let scanLength = stringToScan.length
        
        switch scanLength {
            
        case 3, 4, 6, 8:
            
            let removedSymbolsString = stringToScan.byRemovingAllCharactersExcept(Constants.allowedHexSymbols)
            guard removedSymbolsString.isEqual(to: stringToScan) else { return nil }
            
        default:
            return nil
        }
        
        var components: [CGFloat] = [0.0, 0.0, 0.0, 0.0]
        
        let componentLength: Int = ( scanLength == 6 || scanLength == 8 ) ? 2 : 1
        let hasAlpha = scanLength == 4 || scanLength == 8
        
        var scanLocation: Int = 0
        var componentIndex: Int = 0
        
        while scanLocation < scanLength {
            
            guard var componentScanString = stringToScan.substring(with: NSRange(location: scanLocation, length: componentLength)) else { return nil }
            
            if componentLength == 1 {
                
                componentScanString += componentScanString
            }
            
            var component: UInt64 = 0
            
            let scanner = Scanner(string: componentScanString)
            scanner.scanHexInt64(&component)
            
            components[componentIndex] = CGFloat(component) / 255.0
            
            scanLocation += componentLength
            componentIndex += 1
        }
        
        let r = components[0]
        let g = components[1]
        let b = components[2]
        let a = hasAlpha ? components[3] : 1.0
        
        self.init(rgba: [r, g, b, a])
    }
    
    /// Initializes color with GLfloat RGBA components.
    ///
    /// - Parameter glComponents: GLfloat RGBA components.
    public convenience init?(glComponents: [GLfloat]) {
        
        var rgbaComponents: [CGFloat] = []
        for component in glComponents {
            
            rgbaComponents.append(CGFloat(component))
        }
        
        self.init(rgba: rgbaComponents)
    }
    
    /// Interpolates the color between start and finish.
    ///
    /// - Parameters:
    ///   - start: Start color.
    ///   - finish: Finish color.
    ///   - progress: Progress in range [0, 1]
    /// - Returns: Interpolated color.
    public static func interpolate(start: UIColor, finish: UIColor, progress: CGFloat) -> UIColor {
        
        guard let startRGBA = start.rgbaComponents, let finishRGBA = finish.rgbaComponents else {
            
            fatalError("Failed to get RGBA components.")
        }
        
        let resultingRGBA = type(of: startRGBA).interpolate(start: startRGBA, finish: finishRGBA, progress: progress)
        
        guard let result = UIColor(rgba: resultingRGBA) else {
            
            fatalError("Error in interpolating colors. Please report this problem.")
        }
        
        return result
    }
    
    // MARK: - Private -
    
    private struct Constants {
        
        fileprivate static let allowedHexSymbols = "0123456789ABCDEF"
        fileprivate static let hexPrefix = "#"
    }
}

/// Dummy struct to import UIKit/UIColor module.
public struct UIColorAdditions {
    
    @available (*, unavailable) private init() {
        
        fatalError("\(self) cannot be initialized.")
    }
}
