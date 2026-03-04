//
//  RootTabBarControllerViewController.swift
//  RCA(Programmatic UI)
//
//  Created by 오은택 on 2/27/26.
//

// MARK: - NavTabBar

import UIKit

final class RootTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let formGuideVC = FormGuideVC()
        let homeVC = HomeVC()
        let historyVC = HistoryVC()

        // 보통 탭마다 네비게이션이 필요해서 UINavigationController로 감싼다
        let formNav = UINavigationController(rootViewController: formGuideVC)
        let homeNav = UINavigationController(rootViewController: homeVC)
        let historyNav = UINavigationController(rootViewController: historyVC)

        formNav.tabBarItem = UITabBarItem(
            title: "Form",
            image: UIImage(systemName: "list.bullet.rectangle"),
            selectedImage: UIImage(systemName: "list.bullet.rectangle.fill")
        )

        homeNav.tabBarItem = UITabBarItem(
            title: "Running Form Coach",
            image: UIImage(systemName: "figure.run.treadmill"),
            selectedImage: UIImage(systemName: "figure.run.treadmill")
        )

        historyNav.tabBarItem = UITabBarItem(
            title: "History",
            image: UIImage(systemName: "clock"),
            selectedImage: UIImage(systemName: "clock.fill")
        )

        setViewControllers([formNav, homeNav, historyNav], animated: false)
        selectedIndex = 1
    }
}
