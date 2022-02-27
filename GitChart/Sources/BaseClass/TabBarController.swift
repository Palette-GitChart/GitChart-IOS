//
//  TabBarController.swift
//  GitChart
//
//  Created by 김대희 on 2022/02/07.
//

import UIKit

class TabBarController: UITabBarController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let tabOne = UINavigationController(rootViewController: HomeVC())
        let tabOneBarItem = UITabBarItem(title: "Home", image: UIImage(named: "round_bar_chart"), tag: 1)
        
        tabOne.tabBarItem = tabOneBarItem
        
        let tabTwo = UINavigationController(rootViewController: FriendsVC())
        let tabTwoBarItem2 = UITabBarItem(title: "Friends", image: UIImage(named: "round_groups"), tag: 2)
        
        tabTwo.tabBarItem = tabTwoBarItem2
        
        let tabThr = UINavigationController(rootViewController: StarVC())
        let tabThrBarItem3 = UITabBarItem(title: "Star", image: UIImage(systemName: "star.fill"), tag: 3)
        
        tabThr.tabBarItem = tabThrBarItem3
        
        let tabFou = UINavigationController(rootViewController: SettingVC())
        let tabFouBarItem4 = UITabBarItem(title: "Settings", image: UIImage(systemName: "gearshape.fill"), tag: 4)
        
        tabFou.tabBarItem = tabFouBarItem4
        
        self.tabBar.tintColor = UIColor.appColor(.mainColor)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.appColor(.mainColor)], for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.appColor(.mainColor)], for:.selected)

        self.viewControllers = [tabOne, tabTwo, tabThr, tabFou]
        
    }
}
