//
//  HomeVC.swift
//  GitChart
//
//  Created by 김대희 on 2022/02/07.
//

import UIKit

class HomeVC : BaseViewController {
    
    private let scrollView = UIScrollView().then {
        $0.backgroundColor = .clear
        $0.showsVerticalScrollIndicator = false
    }
    
    private let contentView = UIView().then {
        $0.backgroundColor = .clear
    }
    
    override func viewDidAppear(_ animated: Bool) {
        for view in self.navigationController?.navigationBar.subviews ?? [] {
            let subviews = view.subviews
            if subviews.count > 0, let label = subviews[0] as? UILabel {
                label.textColor = .appColor(.mainColor)
                label.font = FontKit.roundedFont(ofSize: 34, weight: .bold)
            }
        }
    }
    
    
    override func configureUI() {
        self.title = "Home"
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
}
