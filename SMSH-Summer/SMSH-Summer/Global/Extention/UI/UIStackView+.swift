//
//  UIStackView+.swift
//  SMSH-Team6
//
//  Created by 강윤서 on 2022/08/27.
//

import UIKit

extension UIStackView {
     func addArrangedSubviews(_ views: UIView...) {
         for view in views {
             self.addArrangedSubview(view)
         }
     }
}
