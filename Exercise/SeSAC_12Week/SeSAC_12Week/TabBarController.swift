//
//  TabBarController.swift
//  SeSAC_12Week
//
//  Created by 지영 on 2021/12/15.
//

import UIKit
//navigationcontroller, TabbarController
//TabBar, TabBarItem(title, image, selectedImage), tintColor
//iOS13: UITabBarAppearance(버전 분기)
class TabBarController: UITabBarController, UITabBarControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let firstVC = SettingViewController(nibName: "SettingViewController", bundle: nil)
        firstVC.tabBarItem.title = "설정"
        firstVC.tabBarItem.image = UIImage(systemName: "star")
        firstVC.tabBarItem.selectedImage = UIImage(systemName: "star.fill")
        
        let secondVC = SnapDetailViewController()
        secondVC.tabBarItem = UITabBarItem(title: "스냅킷", image: UIImage(systemName: "trash"), selectedImage: UIImage(systemName: "trash.fill"))
        
        let thirdVC = DetailViewController()
        thirdVC.title = "디테일"
        let thirdNav = UINavigationController(rootViewController: thirdVC)
        
        setViewControllers([firstVC, secondVC, thirdNav], animated: true)
        
        // ios13~
        let appearance = UITabBarAppearance()
        appearance.configureWithDefaultBackground()
        
        tabBar.standardAppearance = appearance
        tabBar.scrollEdgeAppearance = appearance
        tabBar.tintColor = .black
        
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        print(item)
    }

}
