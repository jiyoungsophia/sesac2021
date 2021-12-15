//
//  TabBarController.swift
//  55KarrotUIClone
//
//  Created by 지영 on 2021/12/15.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setTabBarItems()

    }
    
    func setTabBarItems() {
        let homeVC = HomeViewController()
        homeVC.tabBarItem = UITabBarItem(title: "홈", image: UIImage(systemName: "house"), selectedImage: UIImage(systemName: "house.fill"))
        
        let myKarrotVC = MyKarrotViewController()
        myKarrotVC.tabBarItem = UITabBarItem(title: "나의 당근", image: UIImage(systemName: "person"), selectedImage: UIImage(systemName: "person.fill"))
        
        setViewControllers([homeVC, myKarrotVC], animated: true)
        
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
    
        tabBar.standardAppearance = appearance
        tabBar.scrollEdgeAppearance = appearance
        tabBar.tintColor = .black
    }
    
    

 
}
