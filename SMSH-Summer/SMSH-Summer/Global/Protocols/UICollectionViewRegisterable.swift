//
//  UICollectionViewRegisterable.swift
//  SMSH-Team6
//
//  Created by 강윤서 on 2022/08/27.
//

import UIKit

protocol UICollectionViewRegisterable {
    static var isFromNib: Bool { get }
    static func register(target: UICollectionView)
}

extension UICollectionViewRegisterable where Self: UICollectionViewCell {
    static func register(target: UICollectionView) {
        if self.isFromNib {
          target.register(UINib(nibName: Self.className, bundle: nil), forCellWithReuseIdentifier: Self.className)
        } else {
          target.register(Self.self, forCellWithReuseIdentifier: Self.className)
        }
    }
}
