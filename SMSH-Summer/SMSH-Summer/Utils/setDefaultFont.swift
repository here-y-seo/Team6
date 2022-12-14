//
//  setDefaultFont.swift
//  SMSH-Team6
//
//  Created by 강윤서 on 2022/08/27.
//

import Foundation
import UIKit

struct AppFontName {
    static let appleSDGothicNeoBold = "AppleSDGothicNeo-Bold"
    static let appleSDGothicNeoMedium = "AppleSDGothicNeo-Medium"
    static let appleSDGothicNeoRegular = "AppleSDGothicNeo-Regular"
    static let appleSDGothicNeoSemiBold = "AppleSDGothicNeo-SemiBold"
    static let ghanaRegular = "Ghanachocolate"
}

extension UIFontDescriptor.AttributeName {
    static let nsctFontUIUsage = UIFontDescriptor.AttributeName(rawValue: "NSCTFontUIUsageAttribute")
}

extension UIFont {

    // MARK: Pretendard Font
    
    @objc class func AppleSDGothicNeoBold(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: AppFontName.appleSDGothicNeoBold, size: size)!
    }
    
    @objc class func AppleSDGothicNeoMedium(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: AppFontName.appleSDGothicNeoMedium, size: size)!
    }
    
    @objc class func AppleSDGothicNeoRegular(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: AppFontName.appleSDGothicNeoRegular, size: size)!
    }
    
    @objc class func AppleSDGothicNeoSemiBold(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: AppFontName.appleSDGothicNeoSemiBold, size: size)!
    }
    
    @objc class func GhanaRegular(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: AppFontName.ghanaRegular, size: size)!
    }

    @objc convenience init(myCoder aDecoder: NSCoder) {
        if let fontDescriptor = aDecoder.decodeObject(forKey: "UIFontDescriptor") as? UIFontDescriptor {
            if let fontAttribute = fontDescriptor.fontAttributes[.nsctFontUIUsage] as? String {
                var fontName = ""
                switch fontAttribute {
                case "CTFontRegularUsage":
                    fontName = AppFontName.appleSDGothicNeoRegular
                case "CTFontEmphasizedUsage", "CTFontBoldUsage":
                    fontName = AppFontName.appleSDGothicNeoBold
                case "CTFontObliqueUsage":
                    fontName = AppFontName.appleSDGothicNeoMedium
                default:
                    fontName = AppFontName.appleSDGothicNeoRegular
                }
                self.init(name: fontName, size: fontDescriptor.pointSize)!
            } else {
                self.init(myCoder: aDecoder)
            }
        } else {
            self.init(myCoder: aDecoder)
        }
    }

     class func overrideInitialize() {
        if self == UIFont.self {
           let systemFontMethod = class_getClassMethod(self, #selector(systemFont(ofSize:)))
           let mySystemFontMethod = class_getClassMethod(self, #selector(AppleSDGothicNeoRegular(ofSize:)))
           method_exchangeImplementations(systemFontMethod!, mySystemFontMethod!)

           let boldSystemFontMethod = class_getClassMethod(self, #selector(boldSystemFont(ofSize:)))
           let myBoldSystemFontMethod = class_getClassMethod(self, #selector(AppleSDGothicNeoBold(ofSize:)))
           method_exchangeImplementations(boldSystemFontMethod!, myBoldSystemFontMethod!)
           let initCoderMethod = class_getInstanceMethod(self, #selector(UIFontDescriptor.init(coder:)))
           let myInitCoderMethod = class_getInstanceMethod(self, #selector(UIFont.init(myCoder:)))
           method_exchangeImplementations(initCoderMethod!, myInitCoderMethod!)
    }
  }
}
