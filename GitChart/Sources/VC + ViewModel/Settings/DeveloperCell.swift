//
//  DeveloperCell.swift
//  GitChart
//
//  Created by 김대희 on 2022/03/24.
//

import UIKit

class DeveloperCell : BaseTableViewCell {
    
    let mainView = UIView().then {
        $0.layer.cornerRadius = 10
        $0.backgroundColor = .appColor(.cellColor)
    }
    
    override func configureUI() {
        contentView.backgroundColor = .appColor(.backgroundColor)
        contentView.addSubview(mainView)
    }
}
