//
//  SettingVC.swift
//  GitChart
//
//  Created by 김대희 on 2022/02/09.
//

import UIKit

class SettingVC : BaseViewController {
    
    override func viewDidAppear(_ animated: Bool) {
        for view in self.navigationController?.navigationBar.subviews ?? [] {
            let subviews = view.subviews
            if subviews.count > 0, let label = subviews[0] as? UILabel {
                label.textColor = .appColor(.labelColor)
                label.font = FontKit.roundedFont(ofSize: 20, weight: .semibold)
            }
        }
    }
    
    override func configureUI() {
        self.title = "Setting"
    }
}
