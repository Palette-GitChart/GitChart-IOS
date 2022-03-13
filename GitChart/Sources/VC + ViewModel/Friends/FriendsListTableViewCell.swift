//
//  FriendsListTableViewCell.swift
//  GitChart
//
//  Created by 김대희 on 2022/03/13.
//

import UIKit

class FriendsListTableViewCell: BaseTableViewCell {
    
    let mainView = UIView().then {
        $0.backgroundColor = .appColor(.cellColor)
        $0.layer.cornerRadius = 20
    }
    
    override func configureUI() {
        contentView.backgroundColor = .appColor(.backgroundColor)
        contentView.addSubview(mainView)
    }
    
}
