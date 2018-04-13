//
//  CAKeyframeAnimation+Additions.swift
//  TapAdditionsKit
//
//  Copyright © 2018 Tap Payments. All rights reserved.
//

import class QuartzCore.CAAnimation.CAKeyframeAnimation
import var QuartzCore.CAAnimation.kCAFillModeForwards
import func QuartzCore.CATransform3D.CATransform3DMakeScale

private let kPopupAppearanceTimeInterval = 0.5
private let kPopupDisappearanceTimeInterval = 0.18

private let kTransformKeyPath = "transform"

/// Useful extension to CAKeyframeAnimation
public extension CAKeyframeAnimation {
    
    // MARK: - Public -
    // MARK: Properties
    
    /// Popup appearance animation (like UIAlertView).
    public static let popupAppearance: CAKeyframeAnimation = {
       
        let animation = CAKeyframeAnimation.transformKeyFrameAnimation
        
        animation.values = CAKeyframeAnimation.popupAppearanceTransforms
        animation.keyTimes = CAKeyframeAnimation.popupAppearanceFrameTimes
        
        animation.fillMode = kCAFillModeForwards
        animation.isRemovedOnCompletion = false
        animation.duration = kPopupAppearanceTimeInterval
        
        return animation
    }()
    
    /// Popup disappearance animation (like UIAlertView).
    public static let popupDisappearance: CAKeyframeAnimation = {
       
        let animation = CAKeyframeAnimation.transformKeyFrameAnimation
        
        animation.values = CAKeyframeAnimation.popupDisappearanceTransforms
        animation.keyTimes = CAKeyframeAnimation.popupDisappearanceFrameTimes
        
        animation.fillMode = kCAFillModeForwards
        animation.isRemovedOnCompletion = false
        animation.duration = kPopupDisappearanceTimeInterval
        
        return animation
    }()
    
    // MARK: - Private -
    // MARK: Properties
    
    private static var transformKeyFrameAnimation: CAKeyframeAnimation {
        
        return CAKeyframeAnimation(keyPath: kTransformKeyPath)
    }
    
    private static let popupAppearanceTransforms: [NSValue] = {
       
        let scale1 = CATransform3DMakeScale(0.5, 0.5, 1.0)
        let scale2 = CATransform3DMakeScale(1.2, 1.2, 1.0)
        let scale3 = CATransform3DMakeScale(0.9, 0.9, 1.0)
        let scale4 = CATransform3DMakeScale(1.0, 1.0, 1.0)
        
        return [NSValue(caTransform3D: scale1), NSValue(caTransform3D: scale2), NSValue(caTransform3D: scale3), NSValue(caTransform3D: scale4)]
    }()
    
    private static let popupDisappearanceTransforms: [NSValue] = {
        
        let scale1 = CATransform3DMakeScale(1.0, 1.0, 1.0)
        let scale2 = CATransform3DMakeScale(0.01, 0.01, 1.0)
        
        return [NSValue(caTransform3D: scale1), NSValue(caTransform3D: scale2)]
    }()
    
    private static let popupAppearanceFrameTimes: [NSNumber] = [0.0, 0.5, 0.9, 1.0]
    
    private static let popupDisappearanceFrameTimes: [NSNumber] = [0.0, 1.0]
}
