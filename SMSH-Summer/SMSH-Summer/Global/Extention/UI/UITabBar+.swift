//
//  UITabBar+.swift
//  SMSH-Team6
//
//  Created by 강윤서 on 2022/08/27.
//

import UIKit

extension UITabBar {
    
    static func clearShadow() {
        UITabBar.appearance().shadowImage = UIImage()
        UITabBar.appearance().backgroundImage = UIImage()
        UITabBar.appearance().backgroundColor = UIColor.white
    }
}
