//
//  UITableViewRegisterable.swift
//  SMSH-Team6
//
//  Created by 강윤서 on 2022/08/27.
//

import UIKit

protocol UITableViewRegisterable {
    static var isFromNib: Bool { get }
    static func register(target: UITableView)
}

extension UITableViewRegisterable where Self: UITableViewCell {
    static func register(target: UITableView) {
        if self.isFromNib {
          target.register(UINib(nibName: Self.className, bundle: nil), forCellReuseIdentifier: Self.className)
        } else {
            target.register(Self.self, forCellReuseIdentifier: Self.className)
        }
    }
}

protocol UITableViewHeaderFooterRegisterable {
    static var isFromNib: Bool { get }
    static func register(target: UITableView)
}

extension UITableViewHeaderFooterRegisterable where Self: UITableViewHeaderFooterView {
    static func register(target: UITableView) {
        if self.isFromNib {
          target.register(UINib(nibName: Self.className, bundle: nil), forHeaderFooterViewReuseIdentifier: Self.className)
        } else {
          target.register(Self.self, forHeaderFooterViewReuseIdentifier: Self.className)
        }
    }
}
