//
//  UIViewController+Additions.swift
//  TapAdditionsKit
//
//  Copyright © 2018 Tap Payments. All rights reserved.
//

import func ObjectiveC.runtime.objc_getAssociatedObject
import func ObjectiveC.runtime.objc_setAssociatedObject
import class UIKit.UIApplication.UIApplication
import enum UIKit.UIApplication.UIInterfaceOrientation
import struct UIKit.UIApplication.UIInterfaceOrientationMask
import class UIKit.UINavigationController.UINavigationController
import class UIKit.NSLayoutConstraint.NSLayoutConstraint
import class UIKit.UIScreen.UIScreen
import class UIKit.UIViewController.UIViewController
import class UIKit.UIWindow.UIWindow
import struct UIKit.UIWindow.UIWindowLevel

private var separateWindowKey: UInt8 = 0

/// Useful UIViewController extension.
public extension UIViewController {
    
    // MARK: - Public -
    // MARK: Properties
    
    /// Defines if receiver is performing any appearance/disappearance transition at the moment.
    public var isPerformingTransition: Bool {
        
        return self.isBeingDismissed || self.isBeingPresented || self.isMovingFromParentViewController || self.isMovingToParentViewController
    }
    
    /// Returns NSLayoutConstraint which determines height of top layout guide.
    public var topLayoutGuideConstraint: NSLayoutConstraint? {
        
        return self.view.constraints.filter { self.topLayoutGuide.isEqual($0.firstItem) && $0.firstAttribute == .height && $0.secondItem == nil }.first
    }
    
    /// Current presented view controller.
    public var currentPresentedViewController: UIViewController? {
        
        if let nonnullPresentedViewController = self.presentedViewController, nonnullPresentedViewController.isFullscreen {
            
            return nonnullPresentedViewController.currentPresentedViewController
        }
        else if let nonnullNavigationController = self as? UINavigationController {
            
            return nonnullNavigationController.visibleViewController?.currentPresentedViewController
        }
        else {
            
            return self
        }
    }
    
    /// Displayed view controller.
    public var displayedViewController: UIViewController? {
        
        if presentedViewController != nil && presentedViewController!.isFullscreen {
            
            return presentedViewController?.displayedViewController
        }
        else if isKind(of: UINavigationController.self) {
            
            return (self as? UINavigationController)?.visibleViewController?.displayedViewController
        }
        else if childViewControllers.count > 0 {
            
            let childControllers = childViewControllers
            for controller in childControllers {
                
                let presentedController = controller.displayedViewController
                if presentedController != controller {
                    
                    return presentedController
                }
            }
            
            return self
        }
        else {
            
            return self
        }
    }
    
    /// Defines if view controller is fullscreen.
    public var isFullscreen: Bool {
        
        if let rootControllerBounds = self.foundWindow?.rootViewController?.view.bounds {
            
            return rootControllerBounds.equalTo(view.bounds)
        }
        else {
            
            return false
        }
    }
    
    // MARK: Methods
    
    /// Loads view if it was not loaded.
    public func loadViewIfNotLoaded() {
        
        if !self.isViewLoaded {
            
            _ = self.view
        }
    }
    
    /// Finds view controller in hieararchy of all windows.
    ///
    /// - Returns: Found view controller or nil if not found.
    public static func findInHierarchy() -> Self? {
        
        return self.findInHierarchy(with: nil)
    }
    
    /// Finds view controller in hieararchy with given root controller.
    ///
    /// - Parameter theRootController: Root view controller. If nil, looks up all hierarchy.
    /// - Returns: Found view controller or nil if not found.
    public static func findInHierarchy<T>(with theRootController: UIViewController?) -> T? {
        
        if let nonnullRootController = theRootController {
            
            return self.inHierarchy(with: nonnullRootController)
        }
        else {
            
            for aWindow in UIApplication.shared.windows {
                
                guard let rootViewController = aWindow.rootViewController else { continue }
                
                let found: T? = self.inHierarchy(with: rootViewController)
                if let nonnullFound = found { return nonnullFound }
            }
            
            return nil
        }
    }
    
    /// Finds and returns top controller of navigation controller of a given view controller.
    ///
    /// - Parameter controller: View controller to find parent.
    /// - Returns: View controller.
    public static func topControllerInNavigationController(for controller: UIViewController) -> UIViewController {
        
        if controller.parent?.navigationController == controller.navigationController {
            
            return topControllerInNavigationController(for: controller.parent!)
        }
        else {
            
            return controller
        }
    }
    
    /// Defines if receiver is a child of anotherViewController.
    ///
    /// - Parameter anotherViewController: View controller to test.
    /// - Returns: Boolean
    public func isChild(of anotherViewController: UIViewController) -> Bool {
        
        var parentController = self.parent
        while parentController != nil {
            
            if parentController == anotherViewController {
                
                return true
            }
            
            parentController = parentController?.parent
        }
        
        return false
    }
    
    /// Shows view controller from 'nowhere' on a separate window.
    ///
    /// - Parameters:
    ///   - animated: Defines if controller should be presented with animation.
    ///   - completion: Completion.
    public func showOnSeparateWindow(_ animated: Bool = true, completion: TypeAlias.ArgumentlessClosure?) {
        
        self.showOnSeparateWindow { (controller) in
            
            controller.present(self, animated: animated, completion: completion)
        }
    }
    
    /// Shows view controller from 'nowhere' giving an option to control the presentation process.
    ///
    /// - Parameter closure: Closure that has view controller as a parameter.
    ///                      This view controller should be the controller that presents the receiver.
    public func showOnSeparateWindow(using closure: TypeAlias.GenericViewControllerClosure<SeparateWindowRootViewController>) {
        
        self.prepareSeparateWindow()
        guard let rootController = self.separateWindow?.rootViewController as? SeparateWindowRootViewController else {
            
            fatalError("A problem occured either instantiating separate window or it hasn't got root view controller.")
        }
        
        closure(rootController)
    }
    
    /// Dismisses view controller.
    ///
    /// - Parameters:
    ///   - animated: Defines if controller should be dismissed with an animation.
    ///   - completion: Closure that will be called when the receiver finishes dismissal process.
    public func dismissFromSeparateWindow(_ animated: Bool = true, completion: TypeAlias.ArgumentlessClosure?) {
        
        self.dismissFromSeparateWindow { (controller) in
            
            controller.dismiss(animated: animated, completion: completion)
        }
    }
    
    /// Dismisses view controller giving an option to dismiss controller manually but control the animation.
    ///
    /// - Parameter closure: Closure has 2 parameters: viewController - controller that presented the receiver. After the dismissal finished, you should call completion closure in order to clean up everything.
    public func dismissFromSeparateWindow(using closure: TypeAlias.UIViewControllerClosure) {
        
        guard let rootController = self.separateWindow?.rootViewController else {
            
            return
        }
        
        closure(rootController)
    }
    
    // MARK: - Private -
    // MARK: Properties
    
    private var separateWindow: UIWindow? {
        
        get {
            
            return objc_getAssociatedObject(self, &separateWindowKey) as? UIWindow
        }
        set {
            
            objc_setAssociatedObject(self, &separateWindowKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    private var foundWindow: UIWindow? {
        
        if let nonnullWindow = self.view.window {
            
            return nonnullWindow
        }
        else if let nonnullParentWindow = self.presentingViewController?.view.window {
            
            return nonnullParentWindow
        }
        else {
            
            return nil
        }
    }
    
    // MARK: Methods
    
    private static func inHierarchy<T>(with theRootController: UIViewController) -> T? {
        
        if let rController = theRootController as? T {
            
            return rController
        }
        
        for childController in theRootController.childViewControllers {
            
            let found: T? = self.inHierarchy(with: childController)
            if let nonnullFound = found { return nonnullFound }
        }
        
        if let presentedController = theRootController.presentedViewController {
            
            let found: T? = self.inHierarchy(with: presentedController)
            if let nonnullFound = found { return nonnullFound }
        }
        
        if let navController = theRootController as? UINavigationController {
            
            for controller in navController.viewControllers {
                
                let found: T? = self.inHierarchy(with: controller)
                if let nonnullFound = found { return nonnullFound }
            }
        }
        
        return nil
    }
    
    private func prepareSeparateWindow() {
        
        self.separateWindow = UIWindow(frame: UIScreen.main.bounds)
        self.separateWindow?.rootViewController = SeparateWindowRootViewController.instantiate { self.removeSeparateWindow() }
        self.separateWindow?.tintColor = self.view.tintColor
        self.separateWindow?.windowLevel = UIWindowLevel.maximalAmongPresented + 1.0
        self.separateWindow?.makeKeyAndVisible()
    }
    
    private func removeSeparateWindow() {
        
        let closestLowerWindow = self.separateWindow?.closestLowerWindow
        
        self.separateWindow?.isHidden = true
        self.separateWindow?.rootViewController = nil
        self.separateWindow = nil
        
        closestLowerWindow?.makeKeyAndVisible()
    }
}

/// This is a class of root view controller in case you want to show view controller on the separate window.
public class SeparateWindowRootViewController: UIViewController {
    
    // MARK: - Public -
    // MARK: Properties
    
    public var allowedInterfaceOrientations: UIInterfaceOrientationMask = .all
    public var preferredInterfaceOrientation: UIInterfaceOrientation?
    public var canAutorotate: Bool = true
    
    public override var shouldAutorotate: Bool {
        
        return self.canAutorotate
    }
    
    public override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        
        return self.allowedInterfaceOrientations
    }
    
    public override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
        
        if let nonnullPreferredOrientation = self.preferredInterfaceOrientation {
            
            return nonnullPreferredOrientation
        }
        else {
            
            return UIApplication.shared.statusBarOrientation
        }
    }
    
    // MARK: Methods
    
    public override func dismiss(animated flag: Bool, completion: TypeAlias.ArgumentlessClosure? = nil) {
        
        let localCompletion: TypeAlias.ArgumentlessClosure = {
            
            self.dismissalCompletionClosure?()
            completion?()
        }
        
        guard self.presentedViewController != nil else {
            
            localCompletion()
            return
        }
        
        super.dismiss(animated: flag, completion: localCompletion)
    }
    
    // MARK: - Fileprivate -
    // MARK: Methods
    
    fileprivate static func instantiate(dismissalCompletion: @escaping TypeAlias.ArgumentlessClosure) -> SeparateWindowRootViewController {
        
        let result = SeparateWindowRootViewController()
        result.dismissalCompletionClosure = dismissalCompletion
        
        return result
    }
    
    // MARK: - Private -
    // MARK: Properties
    
    private var dismissalCompletionClosure: TypeAlias.ArgumentlessClosure?
}
