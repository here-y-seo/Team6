//
//  tabBar.swift
//  SMSH-Summer
//
//  Created by 강윤서 on 2022/08/28.
//

import UIKit

class customTabBar: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setTabBarController()
    }

}

extension customTabBar {
    private func setUI() {
        tabBar.tintColor = .primaryColor
        tabBar.unselectedItemTintColor = .tabBarUnSelected
    }
    
    private func setTabBarController() {
        let homeVC = HomeViewController()
        let writeVC = writeVC()
        let listVC = ListViewController()
        
        homeVC.tabBarItem = UITabBarItem(
        title: "홈",
        image: UIImage(systemName: "house"),
        selectedImage: UIImage(systemName: "house")
        )
        writeVC.tabBarItem = UITabBarItem(
            title: "작성하기",
            image: UIImage(systemName: "square.and.pencil"),
            selectedImage: UIImage(systemName: "square.and.pencil")
        )
        listVC.tabBarItem = UITabBarItem(
            title: "목록보기",
            image: UIImage(systemName: "list.clipboard"),
            selectedImage: UIImage(systemName: "list.clipboard")
        )
        
        setViewControllers([homeVC, writeVC, listVC], animated: true)
    }
}
