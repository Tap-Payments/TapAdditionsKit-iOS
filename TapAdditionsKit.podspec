Pod::Spec.new do |tapAdditionsKit|
    
    tapAdditionsKit.platform = :ios
    tapAdditionsKit.ios.deployment_target = '8.0'
    tapAdditionsKit.swift_version = '4.1'
    tapAdditionsKit.pod_target_xcconfig = { 'SWIFT_VERSION' => '4.1' }
    tapAdditionsKit.name = 'TapAdditionsKit'
    tapAdditionsKit.summary = 'Useful additions for native iOS frameworks'
    tapAdditionsKit.requires_arc = true
    tapAdditionsKit.version = '1.0.9'
    tapAdditionsKit.license = { :type => 'MIT', :file => 'LICENSE' }
    tapAdditionsKit.author = { 'Tap Payments' => 'hello@tap.company' }
    tapAdditionsKit.homepage = 'https://github.com/Tap-Payments/TapAdditionsKit-iOS'
    tapAdditionsKit.source = { :git => 'https://github.com/Tap-Payments/TapAdditionsKit-iOS.git', :tag => tapAdditionsKit.version.to_s }
    tapAdditionsKit.default_subspecs = 'AVFoundation', 'CoreGraphics', 'Foundation', 'ObjectiveC', 'QuartzCore', 'SwiftStandartLibrary', 'Tap', 'UIKit'
    
    tapAdditionsKit.subspec 'AVFoundation' do |avFoundation|
      
        avFoundation.subspec 'AVPlayer' do |avPlayer|
        
            avPlayer.source_files = 'TapAdditionsKit/AVFoundation/AVPlayer+Additions.swift'
        
        end
      
    end
    
    tapAdditionsKit.subspec 'Contacts' do |contacts|
    
        contacts.ios.deployment_target = '9.0'
        
        contacts.subspec 'CNContactFetchRequest' do |cnContactFetchRequest|
            
            cnContactFetchRequest.dependency 'TapAdditionsKit/SwiftStandartLibrary/Array'
            
            cnContactFetchRequest.source_files = 'TapAdditionsKit/Contacts/CNContactFetchRequest+Additions.swift'
            
        end
        
        contacts.subspec 'CNContactStore' do |cnContactStore|
            
            cnContactStore.dependency 'TapAdditionsKit/Contacts/CNContactFetchRequest'
            
            cnContactStore.source_files = 'TapAdditionsKit/Contacts/CNContactStore+Additions.swift'
            
        end
        
        contacts.subspec 'CNInstantMessageAddress' do |cnInstantMessageAddress|
            
            cnInstantMessageAddress.source_files = 'TapAdditionsKit/Contacts/CNInstantMessageAddress+Additions.swift'
            
        end
        
        contacts.subspec 'CNPostalAddress' do |cnPostalAddress|
            
            cnPostalAddress.source_files = 'TapAdditionsKit/Contacts/CNPostalAddress+Additions.swift'
            
        end
        
        contacts.subspec 'CNSocialProfile' do |cnSocialProfile|
            
            cnSocialProfile.source_files = 'TapAdditionsKit/Contacts/CNSocialProfile+Additions.swift'
            
        end
    
    end
    
    tapAdditionsKit.subspec 'CoreGraphics' do |coreGraphics|
        
        coreGraphics.subspec 'CGContext' do |cgContext|
        
            cgContext.source_files = 'TapAdditionsKit/CoreGraphics/CGContext+Additions.swift'
        
        end
        
        coreGraphics.subspec 'CGImage' do |cgImage|
            
            cgImage.dependency 'TapAdditionsKit/CoreGraphics/CGContext'
            
            cgImage.source_files = 'TapAdditionsKit/CoreGraphics/CGImage+Additions.swift'
            
        end
        
        coreGraphics.subspec 'CGPoint' do |cgPoint|
        
            cgPoint.source_files = 'TapAdditionsKit/CoreGraphics/CGPoint+Additions.swift'
        
        end
        
        coreGraphics.subspec 'CGRect' do |cgRect|
            
            cgRect.dependency 'TapAdditionsKit/CoreGraphics/CGPoint'
            cgRect.dependency 'TapAdditionsKit/CoreGraphics/CGSize'
            
            cgRect.source_files = 'TapAdditionsKit/CoreGraphics/CGRect+Additions.swift'
        
        end
        
        coreGraphics.subspec 'CGSize' do |cgSize|
        
            cgSize.dependency 'TapAdditionsKit/SwiftStandartLibrary/Numeric'
        
            cgSize.source_files = 'TapAdditionsKit/CoreGraphics/CGSize+Additions.swift'
        
        end
    
    end
    
    tapAdditionsKit.subspec 'Foundation' do |foundation|
        
        foundation.subspec 'Bundle' do |bundle|
            
            bundle.source_files = 'TapAdditionsKit/Foundation/Bundle+Additions.swift'
            
        end
        
        foundation.subspec 'Calendar' do |calendar|
        
            calendar.source_files = 'TapAdditionsKit/Foundation/Calendar+Additions.swift'
        
        end
        
        foundation.subspec 'Data' do |data|
        
            data.dependency 'TapAdditionsKit/SwiftStandartLibrary/String'
            data.dependency 'TapAdditionsKit/UIKit/UIImage'
            
            data.source_files = 'TapAdditionsKit/Foundation/Data+Additions.swift'
            
        end
        
        foundation.subspec 'Date' do |date|
            
            date.source_files = 'TapAdditionsKit/Foundation/Date+Additions.swift'
            
        end
        
        foundation.subspec 'DateFormatter' do |dateFormatter|
        
            dateFormatter.source_files = 'TapAdditionsKit/Foundation/DateFormatter+Additions.swift'
        
        end
        
        foundation.subspec 'JSONSerialization' do |jsonSerialization|
        
            jsonSerialization.dependency 'TapAdditionsKit/SwiftStandartLibrary/OptionSet'
            jsonSerialization.dependency 'TapAdditionsKit/SwiftStandartLibrary/String'
            jsonSerialization.dependency 'TapAdditionsKit/Tap/TypeAlias'
            jsonSerialization.dependency 'TapSwiftFixes/Exceptions'
            
            jsonSerialization.source_files = 'TapAdditionsKit/Foundation/JSONSerialization+Additions.swift'
        
        end
        
        foundation.subspec 'Locale' do |locale|
        
            locale.source_files = 'TapAdditionsKit/Foundation/Locale+Additions.swift'
        
        end
        
        foundation.subspec 'NSNumber' do |nsNumber|
        
            nsNumber.dependency 'TapAdditionsKit/SwiftStandartLibrary/String'
            nsNumber.dependency 'TapAdditionsKit/Foundation/Locale'
            nsNumber.dependency 'TapAdditionsKit/UIKit/UIDevice'
            
            nsNumber.source_files = 'TapAdditionsKit/Foundation/NSNumber+Additions.swift'
        
        end
        
        foundation.subspec 'NumberFormatter' do |numberFormatter|
        
            numberFormatter.source_files = 'TapAdditionsKit/Foundation/NumberFormatter+Additions.swift'
        
        end
        
        foundation.subspec 'URLSession' do |urlSession|
            
            urlSession.dependency 'TapAdditionsKit/Foundation/URLSessionDataTaskResult'
            
            urlSession.source_files = 'TapAdditionsKit/Foundation/URLSession+Additions.swift'
            
        end
        
        foundation.subspec 'URLSessionDataTaskResult' do |urlSessionDataTaskResult|
        
            urlSessionDataTaskResult.source_files = 'TapAdditionsKit/Foundation/URLSessionDataTaskResult.swift'
        
        end
        
        foundation.subspec 'UserDefaults' do |userDefaults|
            
            userDefaults.source_files = 'TapAdditionsKit/Foundation/UserDefaults+Additions.swift'
            
        end
        
    end
    
    tapAdditionsKit.subspec 'ObjectiveC' do |objectiveC|
    
        objectiveC.subspec 'NSObject' do |nsObject|
        
            nsObject.source_files = 'TapAdditionsKit/ObjectiveC/NSObject+Additions.swift'
        
        end
        
    end
    
    tapAdditionsKit.subspec 'QuartzCore' do |quartzCore|
        
        quartzCore.subspec 'CAKeyframeAnimation' do |caKeyframeAnimation|
            
            caKeyframeAnimation.source_files = 'TapAdditionsKit/QuartzCore/CAKeyframeAnimation+Additions.swift'
            
        end
        
        quartzCore.subspec 'CALayer' do |caLayer|
            
            caLayer.source_files = 'TapAdditionsKit/QuartzCore/CALayer+Additions.swift'
            
        end
        
    end
    
    tapAdditionsKit.subspec 'SwiftStandartLibrary' do |swiftStandartLibrary|
        
        swiftStandartLibrary.subspec 'Array' do |array|
        
            array.dependency 'TapAdditionsKit/SwiftStandartLibrary/Numeric'
        
            array.source_files = 'TapAdditionsKit/SwiftStandartLibrary/Array+Additions.swift'
        
        end
        
        swiftStandartLibrary.subspec 'BinaryInteger' do |binaryInteger|
            
            binaryInteger.source_files = 'TapAdditionsKit/SwiftStandartLibrary/BinaryInteger+Additions.swift'
            
        end
        
        swiftStandartLibrary.subspec 'Bool' do |bool|
        
            bool.source_files = 'TapAdditionsKit/SwiftStandartLibrary/Bool+Additions.swift'
        
        end
        
        swiftStandartLibrary.subspec 'Comparable' do |comparable|
        
            comparable.source_files = 'TapAdditionsKit/SwiftStandartLibrary/Comparable+Additions.swift'
        
        end
        
        swiftStandartLibrary.subspec 'CountableClosedRange' do |countableClosedRange|
        
            countableClosedRange.source_files = 'TapAdditionsKit/SwiftStandartLibrary/CountableClosedRange+Additions.swift'
        
        end
        
        swiftStandartLibrary.subspec 'CustomStringConvertible' do |customStringConvertible|
        
            customStringConvertible.dependency 'TapAdditionsKit/SwiftStandartLibrary/String'
            
            customStringConvertible.source_files = 'TapAdditionsKit/SwiftStandartLibrary/CustomStringConvertible+Additions.swift'
        
        end
        
        swiftStandartLibrary.subspec 'Decodable' do |decodable|
        
            decodable.source_files = 'TapAdditionsKit/SwiftStandartLibrary/Decodable+Additions.swift'
        
        end
        
        swiftStandartLibrary.subspec 'Dictionary' do |dictionary|
        
            dictionary.source_files = 'TapAdditionsKit/SwiftStandartLibrary/Dictionary+Additions.swift'
        
        end
        
        swiftStandartLibrary.subspec 'Encodable' do |encodable|
        
            encodable.source_files = 'TapAdditionsKit/SwiftStandartLibrary/Encodable+Additions.swift'
        
        end
        
        swiftStandartLibrary.subspec 'Float' do |float|
        
            float.dependency 'TapAdditionsKit/SwiftStandartLibrary/Comparable'
            
            float.source_files = 'TapAdditionsKit/SwiftStandartLibrary/Float+Additions.swift'
        
        end
        
        swiftStandartLibrary.subspec 'Int' do |int|
        
            int.source_files = 'TapAdditionsKit/SwiftStandartLibrary/Int+Additions.swift'
        
        end
        
        swiftStandartLibrary.subspec 'KeyedDecodingContainer' do |keyedDecodingContainer|
        
            keyedDecodingContainer.source_files = 'TapAdditionsKit/SwiftStandartLibrary/KeyedDecodingContainer+Additions.swift'
        
        end
        
        swiftStandartLibrary.subspec 'MemoryLayout' do |memoryLayout|
        
            memoryLayout.source_files = 'TapAdditionsKit/SwiftStandartLibrary/MemoryLayout+Additions.swift'
        
        end
        
        swiftStandartLibrary.subspec 'Numeric' do |numeric|
            
            numeric.source_files = 'TapAdditionsKit/SwiftStandartLibrary/Numeric+Additions.swift'
            
        end
        
        swiftStandartLibrary.subspec 'OptionSet' do |optionSet|
        
            optionSet.source_files = 'TapAdditionsKit/SwiftStandartLibrary/OptionSet+Additions.swift'
         
        end
        
        swiftStandartLibrary.subspec 'Sequence' do |sequence|
        
            sequence.source_files = 'TapAdditionsKit/SwiftStandartLibrary/Sequence+Additions.swift'
        
        end
        
        swiftStandartLibrary.subspec 'String' do |string|
            
            string.dependency 'TapAdditionsKit/Foundation/Locale'
            string.dependency 'TapAdditionsKit/Foundation/NumberFormatter'
            string.dependency 'TapAdditionsKit/SwiftStandartLibrary/Int'
            
            string.source_files = 'TapAdditionsKit/SwiftStandartLibrary/String+Additions.swift'
            
        end
        
        swiftStandartLibrary.subspec 'UInt8' do |uint8|
            
            uint8.source_files = 'TapAdditionsKit/SwiftStandartLibrary/UInt8+Additions.swift'
            
        end
        
    end
    
    tapAdditionsKit.subspec 'Tap' do |tap|
    
        tap.subspec 'ClassProtocol' do |classProtocol|
        
            classProtocol.source_files = 'TapAdditionsKit/Tap/ClassProtocol.swift'
        
        end
    
        tap.subspec 'Line' do |line|
            
            line.dependency 'TapAdditionsKit/CoreGraphics/CGPoint'
            
            line.source_files = 'TapAdditionsKit/Tap/Line.swift'
        
        end
        
        tap.subspec 'Triangle' do |triangle|
        
            triangle.dependency 'TapAdditionsKit/Tap/Line'
            
            triangle.source_files = 'TapAdditionsKit/Tap/Triangle.swift'
        
        end
        
        tap.subspec 'TypeAlias' do |typeAlias|
        
            typeAlias.source_files = 'TapAdditionsKit/Tap/TypeAlias.swift'
        
        end
    
    end
    
    tapAdditionsKit.subspec 'UIKit' do |uiKit|
        
        uiKit.subspec 'NSLayoutConstraint' do |nsLayoutConstraint|
            
            nsLayoutConstraint.dependency 'TapAdditionsKit/Tap/TypeAlias'
            nsLayoutConstraint.dependency 'TapAdditionsKit/UIKit/UIView'
            
            nsLayoutConstraint.source_files = 'TapAdditionsKit/UIKit/NSLayoutConstraint+Additions.swift'
        
        end
        
        uiKit.subspec 'UIBezierPath' do |uiBezierPath|
        
            uiBezierPath.dependency 'TapAdditionsKit/CoreGraphics/CGPoint'
            uiBezierPath.dependency 'TapAdditionsKit/SwiftStandartLibrary/Array'
            uiBezierPath.dependency 'TapAdditionsKit/Tap/Line'
        
            uiBezierPath.source_files = 'TapAdditionsKit/UIKit/UIBezierPath+Additions.swift'
        
        end
        
        uiKit.subspec 'UIButton' do |uiButton|
            
            uiButton.dependency 'TapAdditionsKit/UIKit/UIImage'
            
            uiButton.source_files = 'TapAdditionsKit/UIKit/UIButton+Additions.swift'
            
        end
        
        uiKit.subspec 'UICollectionView' do |uiCollectionView|
        
            uiCollectionView.source_files = 'TapAdditionsKit/UIKit/UICollectionView+Additions.swift'
        
        end
        
        uiKit.subspec 'UIColor' do |uiColor|
            
            uiColor.dependency 'TapAdditionsKit/SwiftStandartLibrary/Array'
            uiColor.dependency 'TapAdditionsKit/SwiftStandartLibrary/Int'
            uiColor.dependency 'TapAdditionsKit/SwiftStandartLibrary/String'
            
            uiColor.source_files = 'TapAdditionsKit/UIKit/UIColor+Additions.swift'
            
        end
        
        uiKit.subspec 'UIDevice' do |uiDevice|
        
            uiDevice.source_files = 'TapAdditionsKit/UIKit/UIDevice+Additions.swift'
        
        end
        
        uiKit.subspec 'UIEdgeInsets' do |uiEdgeInsets|
        
            uiEdgeInsets.source_files = 'TapAdditionsKit/UIKit/UIEdgeInsets+Additions.swift'
        
        end
        
        uiKit.subspec 'UIGestureRecognizer' do |uiGestureRecognizer|
        
            uiGestureRecognizer.source_files = 'TapAdditionsKit/UIKit/UIGestureRecognizer+Additions.swift'
        
        end
        
        uiKit.subspec 'UIImage' do |uiImage|
          
            uiImage.dependency 'TapAdditionsKit/CoreGraphics/CGImage'
            uiImage.dependency 'TapAdditionsKit/CoreGraphics/CGSize'
            uiImage.dependency 'TapAdditionsKit/SwiftStandartLibrary/Array'
            uiImage.dependency 'TapAdditionsKit/SwiftStandartLibrary/Sequence'
            uiImage.dependency 'TapAdditionsKit/UIKit/UIColor'
          
            uiImage.source_files = 'TapAdditionsKit/UIKit/UIImage+Additions.swift'
          
        end
        
        uiKit.subspec 'UIImageView' do |uiImageView|
        
            uiImageView.dependency 'TapAdditionsKit/UIKit/UIImage'
            uiImageView.dependency 'TapAdditionsKit/UIKit/UIView'
            
            uiImageView.source_files = 'TapAdditionsKit/UIKit/UIImageView+Additions.swift'
        
        end
        
        uiKit.subspec 'UILabel' do |uiLabel|
        
            uiLabel.dependency 'TapAdditionsKit/Tap/TypeAlias'
        
            uiLabel.source_files = 'TapAdditionsKit/UIKit/UILabel+Additions.swift'
        
        end
        
        uiKit.subspec 'UINavigationController' do |uiNavigationController|
        
            uiNavigationController.dependency 'TapAdditionsKit/Tap/TypeAlias'
            uiNavigationController.dependency 'TapSwiftFixes/Threading'
        
            uiNavigationController.source_files = 'TapAdditionsKit/UIKit/UINavigationController+Additions.swift'
            
        end
        
        uiKit.subspec 'UIResponder' do |uiResponder|
        
            uiResponder.dependency 'TapAdditionsKit/Tap/TypeAlias'
            uiResponder.dependency 'TapAdditionsKit/UIKit/UIView'
            
            uiResponder.source_files = 'TapAdditionsKit/UIKit/UIResponder+Additions.swift'
        
        end
        
        uiKit.subspec 'UIScreen' do |uiScreen|
            
            uiScreen.source_files = 'TapAdditionsKit/UIKit/UIScreen+Additions.swift'
            
        end
        
        uiKit.subspec 'UIScrollView' do |uiScrollView|
        
            uiScrollView.dependency 'TapAdditionsKit/SwiftStandartLibrary/Comparable'
        
            uiScrollView.source_files = 'TapAdditionsKit/UIKit/UIScrollView+Additions.swift'
        
        end
        
        uiKit.subspec 'UITableView' do |uiTableView|
        
            uiTableView.dependency 'TapAdditionsKit/UIKit/UIView'
            uiTableView.dependency 'TapSwiftFixes/Exceptions'
        
            uiTableView.source_files = 'TapAdditionsKit/UIKit/UITableView+Additions.swift'
        
        end
        
        uiKit.subspec 'UIView' do |uiView|
            
            uiView.dependency 'TapAdditionsKit/QuartzCore/CALayer'
            uiView.dependency 'TapAdditionsKit/ObjectiveC/NSObject'
            uiView.dependency 'TapAdditionsKit/SwiftStandartLibrary/String'
            uiView.dependency 'TapAdditionsKit/Tap/TypeAlias'
            uiView.dependency 'TapAdditionsKit/UIKit/UIImage'
            uiView.dependency 'TapAdditionsKit/UIKit/UIScreen'
            
            uiView.source_files = 'TapAdditionsKit/UIKit/UIView+Additions.swift'
            
        end
        
        uiKit.subspec 'UIViewAnimationOptions' do |uiViewAnimationOptions|
        
            uiViewAnimationOptions.source_files = 'TapAdditionsKit/UIKit/UIViewAnimationOptions+Additions.swift'
        
        end
        
        uiKit.subspec 'UIViewController' do |uiViewController|
            
            uiViewController.dependency 'TapAdditionsKit/ObjectiveC/NSObject'
            uiViewController.dependency 'TapAdditionsKit/Tap/TypeAlias'
            uiViewController.dependency 'TapAdditionsKit/UIKit/UIResponder'
            uiViewController.dependency 'TapAdditionsKit/UIKit/UIView'
            uiViewController.dependency 'TapAdditionsKit/UIKit/UIWindow'
            uiViewController.dependency 'TapAdditionsKit/UIKit/UIWindowLevel'
            
            uiViewController.source_files = 'TapAdditionsKit/UIKit/UIViewController+Additions.swift'
            
        end
        
        uiKit.subspec 'UIViewKeyframeAnimationOptions' do |uiViewKeyframeAnimationOptions|
        
            uiViewKeyframeAnimationOptions.source_files = 'TapAdditionsKit/UIKit/UIViewKeyframeAnimationOptions+Additions.swift'
        
        end
        
        uiKit.subspec 'UIWebView' do |uiWebView|
        
            uiWebView.dependency 'TapAdditionsKit/SwiftStandartLibrary/String'
            
            uiWebView.source_files = 'TapAdditionsKit/UIKit/UIWebView+Additions.swift'
        
        end
        
        uiKit.subspec 'UIWindow' do |uiWindow|
        
            uiWindow.dependency 'TapAdditionsKit/UIKit/UIWindowLevel'
            
            uiWindow.source_files = 'TapAdditionsKit/UIKit/UIWindow+Additions.swift'
        
        end
        
        uiKit.subspec 'UIWindowLevel' do |uiWindowLevel|
        
            uiWindowLevel.source_files = 'TapAdditionsKit/UIKit/UIWindowLevel+Additions.swift'
        
        end
    end
end
