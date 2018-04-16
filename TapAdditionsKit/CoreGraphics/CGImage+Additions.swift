//
//  CGImage+Additions.swift
//  TapAdditionsKit
//
//  Copyright © 2018 Tap Payments. All rights reserved.
//

import func Accelerate.vImage.Convolution.vImageBoxConvolve_ARGB8888
import var Accelerate.vImage.vImage_Types.kvImageEdgeExtend
import var Accelerate.vImage.vImage_Types.kvImageGetTempBufferSize
import struct Accelerate.vImage.vImage_Types.vImage_Buffer
import struct Accelerate.vImage.vImage_Types.vImage_Flags
import struct Accelerate.vImage.vImage_Types.vImagePixelCount
import enum CoreGraphics.CGContext.CGBlendMode
import class CoreGraphics.CGContext.CGContext
import struct CoreGraphics.CGGeometry.CGSize
import class CoreGraphics.CGImage.CGImage
import class UIKit.UIColor.UIColor

/// Useful additions to CGImage.
public extension CGImage {
    
    // MARK: - Public -
    // MARK: Properties
    
    /// Bytes count.
    public var bytesCount: Int {
        
        return self.bytesPerRow * self.height
    }
    
    /// Image size.
    public var size: CGSize {
        
        return CGSize(width: self.width, height: self.height)
    }
    
    // MARK: Methods
    
    public func blurred(with boxSize: UInt32, iterations: Int, blendColor: UIColor?, blendMode: CGBlendMode) -> CGImage? {
        
        guard let providerData = self.dataProvider?.data else { return nil }
        guard let inData = malloc(self.bytesCount) else { return nil }
        
        var inBuffer = self.imageBuffer(from: inData)
        
        guard let outData = malloc(self.bytesCount) else { return nil }
        var outBuffer = self.imageBuffer(from: outData)
        
        let tempSize = vImageBoxConvolve_ARGB8888(&inBuffer, &outBuffer, nil, 0, 0, boxSize, boxSize, nil, vImage_Flags(kvImageEdgeExtend + kvImageGetTempBufferSize))
        let tempData = malloc(tempSize)
        
        defer {
            
            free(inData)
            free(outData)
            free(tempData)
        }
        
        let source = CFDataGetBytePtr(providerData)
        memcpy(inBuffer.data, source, self.bytesCount)
        
        for _ in 0..<iterations {
            
            vImageBoxConvolve_ARGB8888(&inBuffer, &outBuffer, tempData, 0, 0, boxSize, boxSize, nil, vImage_Flags(kvImageEdgeExtend))
            
            let temp = inBuffer.data
            inBuffer.data = outBuffer.data
            outBuffer.data = temp
        }
        
        let context = self.colorSpace.flatMap {
            
            CGContext(data: inBuffer.data, width: self.width, height: self.height, bitsPerComponent: self.bitsPerComponent, bytesPerRow: self.bytesPerRow, space: $0, bitmapInfo: self.bitmapInfo.rawValue)
        }
        
        return context?.makeImage(with: blendColor, blendMode: blendMode, size: self.size)
    }
    
    // MARK: - Private -
    // MARK: Methods
    
    private func imageBuffer(from data: UnsafeMutableRawPointer) -> vImage_Buffer {
        
        return vImage_Buffer(data: data, height: vImagePixelCount(self.height), width: vImagePixelCount(self.width), rowBytes: self.bytesPerRow)
    }
}

/// Dummy struct to import CoreGraphics/CGImage module.
public struct CGImageAdditions {
    
    @available (*, unavailable) private init() {
        
        fatalError("\(self) cannot be initialized.")
    }
}
