//
//  TabBarController.swift
//  GitChart
//
//  Created by 김대희 on 2022/02/07.
//

import UIKit

class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let tabOne = UINavigationController(rootViewController: MainHomeViewController())
        let tabOneBarItem = UITabBarItem(title: "홈", image: UIImage(named: "baseline_home_black"), tag: 1)
        
        tabOne.tabBarItem = tabOneBarItem
        
        let tabTwo = UINavigationController(rootViewController: SendMoneyViewController())
        let tabTwoBarItem2 = UITabBarItem(title: "송금", image: UIImage(named: "baseline_paid_black"), tag: 2)
        
        tabTwo.tabBarItem = tabTwoBarItem2
        
        let tabThr = UINavigationController(rootViewController: StockUIViewController())
        let tabThrBarItem3 = UITabBarItem(title: "주식", image: UIImage(named: "baseline_trending_up_black"), tag: 3)
        
        tabThr.tabBarItem = tabThrBarItem3
        
        let tabFou = UINavigationController(rootViewController: OtherViewController())
        let tabFouBarItem4 = UITabBarItem(title: "더보기", image: UIImage(named: "round_subject_black"), tag: 4)
        
        tabFou.tabBarItem = tabFouBarItem4
        

    }
}
