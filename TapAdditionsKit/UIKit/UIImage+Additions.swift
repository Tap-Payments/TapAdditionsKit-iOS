//
//  UIImage+Additions.swift
//  TapAdditionsKit
//
//  Copyright © 2018 Tap Payments. All rights reserved.
//

import var Accelerate.vImage.kvImageEdgeExtend
import var Accelerate.vImage.kvImageNoFlags
import struct Accelerate.vImage.vImage_Buffer
import func Accelerate.vImage.vImageBoxConvolve_ARGB8888
import func Accelerate.vImage.vImageMatrixMultiply_ARGB8888
import struct Accelerate.vImage.vImagePixelCount
import struct Accelerate.vImage.vImage_Flags
import struct CoreGraphics.CGAffineTransform
import struct CoreGraphics.CGBase.CGFloat
import class CoreGraphics.CGContext.CGContext
import enum CoreGraphics.CGContext.CGBlendMode
import struct CoreGraphics.CGGeometry.CGPoint
import struct CoreGraphics.CGGeometry.CGRect
import struct CoreGraphics.CGGeometry.CGSize
import class CoreGraphics.CGImage.CGImage
import class CoreImage.CIContext.CIContext
import class CoreImage.CIFilter.CIFilter
import class CoreImage.CIImage.CIImage
import var CoreImage.kCIInputImageKey
import var CoreImage.kCIOutputImageKey
import class ImageIO.CGImageSource
import func ImageIO.CGImageSource.CGImageSourceCopyPropertiesAtIndex
import func ImageIO.CGImageSource.CGImageSourceCreateImageAtIndex
import func ImageIO.CGImageSource.CGImageSourceCreateWithData
import func ImageIO.CGImageSource.CGImageSourceGetCount
import var ImageIO.CGImageSource.kCGImagePropertyGIFDelayTime
import var ImageIO.CGImageSource.kCGImagePropertyGIFDictionary
import class UIKit.UIBezierPath.UIBezierPath
import class UIKit.UIColor.UIColor
import struct UIKit.UIEdgeInsets
import func UIKit.UIGraphicsBeginImageContext
import func UIKit.UIGraphicsBeginImageContextWithOptions
import func UIKit.UIGraphicsEndImageContext
import func UIKit.UIGraphicsGetCurrentContext
import func UIKit.UIGraphicsGetImageFromCurrentImageContext
import class UIKit.UIImage.UIImage
import func UIKit.UIImage.UIImagePNGRepresentation
import class UIKit.UIScreen.UIScreen
import class UIKit.UIView.UIView

typealias CIImageRef = CIImage

private let kMinimalImageSizeForInstagram = CGSize(width: 612.0, height: 612.0)

/// Useful extension of UIImage class.
public extension UIImage {
    
    // MARK: - Public -
    // MARK: Properties
    
    /// Returns mirrored image.
    public var mirrored: UIImage {
        
        return UIImage(cgImage: self.nonnullCGImage, scale: self.scale, orientation: .upMirrored)
    }
    
    /// Returns stretchable copy of the receiver.
    public var stretchableImage: UIImage {
        
        let topInset = 0.5 * size.height
        let leftInset = 0.5 * size.width
        let capInsets = UIEdgeInsets(top: topInset, left: leftInset, bottom: topInset + 1.0, right: leftInset + 1.0)
        
        return resizableImage(withCapInsets: capInsets)
    }
    
    /// Returns tileable copy of the receiver.
    public var tileableImage: UIImage {
        
        return resizableImage(withCapInsets: UIEdgeInsets.zero, resizingMode: .tile)
    }
    
    /// Predefines if image is large enough for Instagram.
    public var isLargeEnoughForInstagram: Bool {
        
        return self.size.width  * self.scale >= kMinimalImageSizeForInstagram.width &&
            self.size.height * self.scale >= kMinimalImageSizeForInstagram.height
    }
    
    /// Defines if image has square form.
    public var isSquare: Bool {
        
        return self.size.isSquare
    }
    
    /// Returns transparent copy of the receiver.
    public var transparentImage: UIImage? {
        
        guard let imageData = UIImagePNGRepresentation(self) else { return nil }
        return UIImage(data: imageData)
    }
    
    /// Returns negative copy of the receiver.
    public var negativeImage: UIImage? {
        
        let ciImage = self.nonnullCIImage
        let negativeFilter = CIFilter(name: "CIColorInvert")
        negativeFilter?.setValue(ciImage, forKey: kCIInputImageKey)
        
        if let resultCIImage = negativeFilter?.value(forKey: kCIOutputImageKey) as? CIImageRef {
            
            return UIImage(ciImage: resultCIImage, scale: scale, orientation: imageOrientation)
        }
        else {
            
            return nil
        }
    }
    
    /// Returns black-and-white image with inverted mask.
    public var invertedMaskImage: UIImage? {
        
        let cgImage = self.nonnullCGImage
        let decode: [CGFloat] = [1.0, 0.0, 0.0, 1.0, 0.0, 1.0, 0.0, 1.0]
        
        let resultCGImage = CGImage(width: cgImage.width,
                                    height: cgImage.height,
                                    bitsPerComponent: cgImage.bitsPerComponent,
                                    bitsPerPixel: cgImage.bitsPerPixel,
                                    bytesPerRow: cgImage.bytesPerRow,
                                    space: cgImage.colorSpace!,
                                    bitmapInfo: cgImage.bitmapInfo,
                                    provider: cgImage.dataProvider!,
                                    decode: decode,
                                    shouldInterpolate: cgImage.shouldInterpolate,
                                    intent: cgImage.renderingIntent)
        
        let resultUIImage = UIImage(cgImage: resultCGImage!, scale: self.scale, orientation: self.imageOrientation)
        return resultUIImage
    }
    
    /// Returns nonnull backing CGImage.
    public var nonnullCGImage: CGImage {
        
        return ciImage == nil ? cgImage! : CIContext().createCGImage(ciImage!, from: ciImage!.extent)!
    }
    
    /// Returns nonnull backing CIImage.
    public var nonnullCIImage: CIImage {
        
        return cgImage == nil ? ciImage! : CIImage(cgImage: cgImage!)
    }
    
    // MARK: Methods
    
    /**
     Initializes image with GIF data.
     
     - parameter data: GIF image data.
     
     - returns: New instance of UIImage or nil if data is wrong.
     */
    public static func imageWithAnimatedGIFData(_ data: Data) -> UIImage? {
        
        let imageSource = CGImageSourceCreateWithData(data as CFData, nil)
        return self.animatedImageWithAnimatedGIF(imageSource: imageSource)
    }
    
    /**
     Initializes an image by combining all the images from array into one putting one after another with the same left bound.
     
     - parameter imagesArray: Images to combine.
     
     - returns: A new instance of UIImage.
     */
    public convenience init?(byCombiningImages imagesArray: [UIImage]) {
        
        var offset = CGPoint.zero
        var maximalWidth: CGFloat = 0.0
        
        var pointImages: [NSValue: UIImage] = [:]
        for image in imagesArray {
            
            pointImages[NSValue(cgPoint: offset)] = image
            offset.y += image.size.height
            
            let imageWidth = image.size.width
            if imageWidth > maximalWidth {
                
                maximalWidth = imageWidth
            }
        }
        
        self.init(byCombiningImages: pointImages, withResultingSize: CGSize(width: maximalWidth, height: offset.y), backgroundColor: UIColor.clear, clearImageLocations: false)
    }
    
    /**
     Initializes an image by combining all the images from array into one with given image locations, resulting size and background color.
     
     - parameter imagesDictionary:    Images dictionary in format [NSValue(CGPoint) : UIImage]. [ image location : image ]
     - parameter size:                Resulting image size.
     - parameter backgroundColor:     Image background fill color.
     - parameter clearImageLocations: Defines if clearRect() should be called before drawing another image.
     
     - returns: A new instance of UIImage or nil if error occured.
     */
    public convenience init?(byCombiningImages imagesDictionary: [NSValue: UIImage], withResultingSize size: CGSize, backgroundColor: UIColor, clearImageLocations: Bool) {
        
        var maximalScale: CGFloat = 1.0
        
        for (_, image) in imagesDictionary {
            
            let imageScale = image.scale
            if imageScale > maximalScale {
                
                maximalScale = imageScale
            }
        }
        
        maximalScale.round(.toNearestOrEven)
        
        UIGraphicsBeginImageContextWithOptions(size, false, maximalScale)
        
        guard let context = UIGraphicsGetCurrentContext() else {
            
            UIGraphicsEndImageContext()
            return nil
        }
        
        context.saveGState()
        
        context.clear(CGRect(origin: CGPoint.zero, size: size))
        context.setFillColor(backgroundColor.cgColor)
        context.fill(CGRect(origin: CGPoint.zero, size: size))
        
        for ( pointValue, image ) in imagesDictionary {
            
            let point = pointValue.cgPointValue
            
            if clearImageLocations {
                
                context.clear(CGRect(origin: point, size: image.size))
            }
            
            image.draw(at: point)
        }
        
        guard let result = UIGraphicsGetImageFromCurrentImageContext() else {
            
            context.restoreGState()
            UIGraphicsEndImageContext()
            return nil
        }
        
        context.restoreGState()
        UIGraphicsEndImageContext()
        
        let cgResult = result.nonnullCGImage
        
        self.init(cgImage: cgResult, scale: result.scale, orientation: result.imageOrientation)
    }
    
    /**
     Initializes an image of a given size with a given color.
     
     - parameter size:  Image size.
     - parameter color: Image fill color.
     
     - returns: New instance of UIImage or nil if it could not be created.
     */
    public convenience init?(size: CGSize, fillColor color: UIColor) {
        
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        
        guard let context = UIGraphicsGetCurrentContext() else {
            
            UIGraphicsEndImageContext()
            return nil
        }
        
        context.saveGState()
        context.clear(CGRect(origin: CGPoint.zero, size: size))
        context.setFillColor(color.cgColor)
        context.fill(CGRect(origin: CGPoint.zero, size: size))
        
        guard let image = UIGraphicsGetImageFromCurrentImageContext() else {
            
            context.restoreGState()
            UIGraphicsEndImageContext()
            return nil
        }
        
        context.restoreGState()
        UIGraphicsEndImageContext()
        
        self.init(cgImage: image.nonnullCGImage, scale: image.scale, orientation: image.imageOrientation)
    }
    
    /**
     Returns copy of the receiver by applying light blur effect.
     
     - returns: New instance of UIImage or nil if error occured.
     */
    public func applyLightEffect() -> UIImage? {
        
        return self.applyBlur(with: 20.0, tintColor: .lightBlurTintColor, saturationDeltaFactor: 1.8, maskImage: nil)
    }
    
    /**
     Returns copy of the receiver by applying extra light blur effect.
     
     - returns: New instance of UIImage or nil if error occured.
     */
    public func applyExtraLightEffect() -> UIImage? {
        
        return self.applyBlur(with: 20.0, tintColor: .extraLightBlurTintColor, saturationDeltaFactor: 1.8, maskImage: nil)
    }
    
    /**
     Returns copy of the receiver by applying dark blur effect.
     
     - returns: New instance of UIImage or nil if error occured.
     */
    public func applyDarkEffect() -> UIImage? {
        
        return self.applyBlur(with: 20.0, tintColor: .darkBlurTintColor, saturationDeltaFactor: 1.8, maskImage: nil)
    }
    
    /**
     Applies tint effect to the image.
     
     - parameter tintColor: Tint color.
     
     - returns: A tinted copy of the receiver or nil if an error occured.
     */
    public func applyTintEffect(with tintColor: UIColor) -> UIImage? {
        
        let effectColorAlpha: CGFloat = 0.6
        
        var effectColor = tintColor
        
        if tintColor.cgColor.numberOfComponents == 2 {
            
            var white: CGFloat = 0
            if tintColor.getWhite(&white, alpha: nil) {
                
                effectColor = UIColor(white: white, alpha: effectColorAlpha)
            }
        }
        else {
            
            var red: CGFloat = 0
            var green: CGFloat = 0
            var blue: CGFloat = 0
            
            if tintColor.getRed(&red, green: &green, blue: &blue, alpha: nil) {
                
                effectColor = UIColor(red: red, green: green, blue: blue, alpha: effectColorAlpha)
            }
        }
        
        return applyBlur(with: 10.0, tintColor: effectColor, saturationDeltaFactor: -1.0, maskImage: nil)
    }
    
    /**
     Returns copy of the receiver by applying blur effect to it.
     
     - parameter blurRadius:            Blur radius.
     - parameter tintColor:             Tint color.
     - parameter saturationDeltaFactor: Saturation delta factor.
     - parameter maskImage:             Masking image.
     
     - returns: A new instance of UIImage or nil if error occured.
     */
    public func applyBlur(with blurRadius: CGFloat, tintColor: UIColor?, saturationDeltaFactor: CGFloat, maskImage: UIImage?) -> UIImage? {
        
        guard size.width >= 1.0 && size.height >= 1.0 else {
            
            print("Invalid image size: (\(size.width), \(size.height))")
            return nil
        }
        
        let imageRect = CGRect(origin: CGPoint.zero, size: size)
        var effectImage = self
        
        let hasBlur = blurRadius > CGFloat.ulpOfOne
        let hasSaturationChange = fabs(saturationDeltaFactor - 1.0) > CGFloat.ulpOfOne
        if hasBlur || hasSaturationChange {
            
            UIGraphicsBeginImageContextWithOptions(size, false, UIScreen.main.scale)
            
            guard let effectInContext = UIGraphicsGetCurrentContext() else {
                
                UIGraphicsEndImageContext()
                return nil
            }
            
            effectInContext.scaleBy(x: 1.0, y: -1.0)
            effectInContext.translateBy(x: 0, y: -size.height)
            effectInContext.draw(nonnullCGImage, in: imageRect)
            
            var effectInBuffer = vImage_Buffer(context: effectInContext)
            
            UIGraphicsBeginImageContextWithOptions(size, false, UIScreen.main.scale)
            
            guard let effectOutContext = UIGraphicsGetCurrentContext() else {
                
                UIGraphicsEndImageContext()
                UIGraphicsEndImageContext()
                return nil
            }
            
            var effectOutBuffer = vImage_Buffer(context: effectOutContext)
            
            if hasBlur {
                
                let inputRadius = blurRadius * UIScreen.main.scale
                
                let sqrt2Pi = sqrt(Double.pi * 2.0)
                let doubleRadius = Double(inputRadius) * 3.0 * sqrt2Pi / 4.0 + 0.5
                
                var radius: UInt32 = UInt32(floor(doubleRadius))
                if radius % 2 != 1 {
                    
                    radius += 1
                }
                
                vImageBoxConvolve_ARGB8888(&effectInBuffer, &effectOutBuffer, nil, 0, 0, radius, radius, nil, vImage_Flags(kvImageEdgeExtend))
                vImageBoxConvolve_ARGB8888(&effectOutBuffer, &effectInBuffer, nil, 0, 0, radius, radius, nil, vImage_Flags(kvImageEdgeExtend))
                vImageBoxConvolve_ARGB8888(&effectInBuffer, &effectOutBuffer, nil, 0, 0, radius, radius, nil, vImage_Flags(kvImageEdgeExtend))
            }
            
            var effectImageBuffersAreSwapped = false
            if hasSaturationChange {
                
                let floatingPointSaturationMatrix: [CGFloat] = type(of: self).blurSaturationMatrix(with: saturationDeltaFactor)
                
                let divisor = 256
                let matrixSize = floatingPointSaturationMatrix.count
                
                var saturationMatrix: [Int16] = []
                for index in 0..<matrixSize {
                    
                    saturationMatrix.append(Int16(round(floatingPointSaturationMatrix[index] * CGFloat(divisor))))
                }
                
                if hasBlur {
                    
                    vImageMatrixMultiply_ARGB8888(&effectOutBuffer, &effectInBuffer, saturationMatrix, Int32(divisor), nil, nil, vImage_Flags(kvImageNoFlags))
                    effectImageBuffersAreSwapped = true
                }
                else {
                    
                    vImageMatrixMultiply_ARGB8888(&effectInBuffer, &effectOutBuffer, saturationMatrix, Int32(divisor), nil, nil, vImage_Flags(kvImageNoFlags))
                }
            }
            
            if !effectImageBuffersAreSwapped {
                
                effectImage = UIGraphicsGetImageFromCurrentImageContext()!
            }
            
            UIGraphicsEndImageContext()
            
            if effectImageBuffersAreSwapped {
                
                effectImage = UIGraphicsGetImageFromCurrentImageContext()!
            }
            
            UIGraphicsEndImageContext()
        }
        
        UIGraphicsBeginImageContextWithOptions(size, false, UIScreen.main.scale)
        
        guard let outputContext = UIGraphicsGetCurrentContext() else {
            
            UIGraphicsEndImageContext()
            return nil
        }
        
        outputContext.scaleBy(x: 1.0, y: -1.0)
        outputContext.translateBy(x: 0, y: -size.height)
        
        outputContext.draw(self.nonnullCGImage, in: imageRect)
        
        if hasBlur {
            
            outputContext.saveGState()
            if let nonnullMaskImage = maskImage {
                
                outputContext.clip(to: imageRect, mask: nonnullMaskImage.nonnullCGImage)
            }
            
            outputContext.draw(effectImage.nonnullCGImage, in: imageRect)
            outputContext.restoreGState()
        }
        
        if tintColor != nil {
            
            outputContext.saveGState()
            outputContext.setFillColor(tintColor!.cgColor)
            outputContext.fill(imageRect)
            outputContext.restoreGState()
        }
        
        let outputImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return outputImage
    }
    
    /**
     Returns rotated copy of the receiver.
     
     - parameter degrees: Degrees
     
     - returns: Rotated copy of the receiver.
     */
    public func rotate(degrees: CGFloat) -> UIImage? {
        
        let angle = degrees * CGFloat.pi / 180.0
        
        let rotatedViewBox = UIView(frame: CGRect(origin: CGPoint.zero, size: size))
        rotatedViewBox.transform = CGAffineTransform(rotationAngle: angle)
        
        let rotatedSize = rotatedViewBox.frame.size
        
        UIGraphicsBeginImageContext(rotatedSize)
        guard let bitmap = UIGraphicsGetCurrentContext() else {
            
            UIGraphicsEndImageContext()
            return nil
        }
        
        bitmap.translateBy(x: 0.5 * rotatedSize.width, y: 0.5 * rotatedSize.height)
        bitmap.rotate(by: angle)
        bitmap.scaleBy(x: 1.0, y: -1.0)
        
        bitmap.draw(self.nonnullCGImage, in: CGRect(origin: CGPoint(x: -0.5 * size.width, y: -0.5 * size.height), size: size))
        
        let result = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        return result
    }
    
    /**
     Creates new image from receiver by rounding corners.
     
     - parameter cornerRadius: Corner radius.
     
     - returns: New instance of UIImage.
     */
    public func byRoundingCorners(cornerRadius: CGFloat) -> UIImage? {
        
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        
        let path = UIBezierPath(roundedRect: CGRect(origin: CGPoint.zero, size: size), cornerRadius: cornerRadius)
        path.addClip()
        draw(at: CGPoint.zero)
        
        let result = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        return result
    }
    
    /**
     Returns color of a given point.
     
     - parameter point: Point to get the color.
     
     - returns: UIColor or nil if point is outside the image.
     */
    public func color(at point: CGPoint) -> UIColor? {
        
        guard CGRect(origin: CGPoint.zero, size: size).contains(point) else { return nil }
        
        guard let pixelData = self.nonnullCGImage.dataProvider?.data, let data = CFDataGetBytePtr(pixelData) else { return nil }
        
        let pixelInfo = Int(4 * ( size.width * point.y + point.x ))
        
        let red = CGFloat(data[pixelInfo + 2]) / 255.0
        let green = CGFloat(data[pixelInfo + 1]) / 255.0
        let blue = CGFloat(data[pixelInfo]) / 255.0
        let alpha = CGFloat(data[pixelInfo + 3]) / 255.0
        
        return UIColor(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    /// scale image to new image
    ///
    /// - Parameter aSize: size of new image
    /// - Returns: resized image
    public func scaleToSize(_ aSize: CGSize) -> UIImage? {
        
        guard !self.size.equalTo(aSize) else { return self }
        
        UIGraphicsBeginImageContextWithOptions(aSize, false, 0.0)
        self.draw(in: CGRect.init(x: 0.0, y: 0.0, width: aSize.width, height: aSize.height))
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
    public func blurred(withRadius radius: CGFloat, iterations: Int, ratio: CGFloat, blendColor color: UIColor?, blendMode mode: CGBlendMode) -> UIImage? {
        
        let cgImage = self.nonnullCGImage
        
        if cgImage.size.area <= 0 || radius <= 0 { return self }
        
        var boxSize = UInt32(radius * self.scale * ratio)
        if boxSize % 2 == 0 {
            
            boxSize += 1
        }
        
        return cgImage.blurred(with: boxSize, iterations: iterations, blendColor: color, blendMode: mode).map {
            
            UIImage(cgImage: $0, scale: scale, orientation: imageOrientation)
        }
    }
    
    // MARK: - Private -
    // MARK: Methods
    
    private static func animatedImageWithAnimatedGIF(imageSource: CGImageSource?) -> UIImage? {
        
        guard let nonnullImageSource = imageSource else { return nil }
        
        let count = CGImageSourceGetCount(nonnullImageSource)
        
        guard let gifImageFrames = self.createImagesAndDelays(source: nonnullImageSource, count: count) else { return nil }
        
        let images = gifImageFrames.map { return $0.image }
        let delays = gifImageFrames.map { return $0.delay }
        
        let totalDurationCentiseconds = delays.sum
        let duration = TimeInterval(totalDurationCentiseconds) / 100.0
        
        guard let frames = self.frameArray(size: count,
                                           images: images,
                                           delays: delays,
                                           totalDurationInCentiseconds: Int(duration)) else { return nil }
        
        return UIImage.animatedImage(with: frames, duration: duration)
    }
    
    private static func createImagesAndDelays(source: CGImageSource!, count: size_t) -> [GIFImageFrame]? {
        
        var result: [GIFImageFrame] = []
        
        for index in 0..<count {
            
            if let image = CGImageSourceCreateImageAtIndex(source, index, nil) {
                
                result.append(GIFImageFrame(image: image, delay: self.delayCentiseconds(for: source, index: index)))
            }
            else {
                
                return nil
            }
        }
        
        return result
    }
    
    private static func delayCentiseconds(for imageSource: CGImageSource, index: Int) -> Int {
        
        var delayCentiseconds = 1
        
        if let properties = CGImageSourceCopyPropertiesAtIndex(imageSource, index, nil) as NSDictionary? {
            
            if let gifProperties = properties[kCGImagePropertyGIFDictionary as String] as? NSDictionary {
                
                if let gifDelayNumber = gifProperties[kCGImagePropertyGIFDelayTime as String] as? NSNumber {
                    
                    delayCentiseconds = lrint(gifDelayNumber.doubleValue * 100.0)
                }
            }
        }
        
        return delayCentiseconds
    }
    
    private static func frameArray(size: Int, images: [CGImage], delays: [Int], totalDurationInCentiseconds: Int) -> [UIImage]? {
        
        let gcd = delays.gcd
        guard gcd > 0 else { return nil }
        
        var frames: [UIImage] = []
        
        for index in 0..<size {
            
            let frame = UIImage(cgImage: images[index])
            for _ in stride(from: delays[index] / gcd, to: 0, by: -1) {
                
                frames.append(frame)
            }
        }
        
        return frames
    }
    
    private static func blurSaturationMatrix(with deltaFactor: CGFloat) -> [CGFloat] {
        
        let z00722: CGFloat = 0.0722
        let z07152: CGFloat = 0.7152
        let z02126: CGFloat = 0.2126
        
        let f00722 = z00722 * deltaFactor
        let f09278 = deltaFactor - f00722
        let f07152 = z07152 * deltaFactor
        let f02848 = deltaFactor - f07152
        let f02126 = z02126 * deltaFactor
        let f07873 = 0.7873 * deltaFactor // why 0.7873 instead of 0.7874 - unknown
        
        let e00 = z00722 + f09278
        let e01 = z00722 - f00722
        let e02 = z00722 - f00722
        
        let e04 = z07152 - f07152
        let e05 = z07152 + f02848
        
        let e08 = z02126 - f02126
        let e10 = z02126 + f07873
        
        let zero: CGFloat = 0.0
        let one: CGFloat = 1.0
        
        let result: [CGFloat] = [
            
            e00, e01, e02, zero,
            e04, e05, e04, zero,
            e08, e08, e10, zero,
            zero, zero, zero, one
        ]
        
        return result
    }
}

fileprivate extension vImage_Buffer {
    
    fileprivate init(context: CGContext) {
        
        self.init(data: context.data,
                  height: vImagePixelCount(context.height),
                  width: vImagePixelCount(context.width),
                  rowBytes: context.bytesPerRow)
    }
}

private struct GIFImageFrame {
    
    fileprivate var image: CGImage
    fileprivate var delay: Int
}
