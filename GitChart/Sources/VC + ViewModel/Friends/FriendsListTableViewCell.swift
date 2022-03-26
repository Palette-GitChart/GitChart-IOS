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
    
    let friendUserImage = UIImageView().then {
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 20
        $0.layer.borderWidth = 0.5
        $0.layer.borderColor = UIColor.secondaryLabel.cgColor
    }
    
    let friendNameLabel = UILabel().then {
        $0.font = .roundedFont(ofSize: 22, weight: .medium)
        $0.textColor = .appColor(.labelColor)
    }

    override func configureUI() {
        contentView.backgroundColor = .appColor(.backgroundColor)
        contentView.addSubview(mainView)
        [friendUserImage, friendNameLabel].forEach {
            mainView.addSubview($0)
        }
    }
    
    override func setupConstraints() {
        mainView.snp.makeConstraints {
            $0.left.right.equalTo(contentView).inset(15)
            $0.top.equalTo(contentView).offset(5)
            $0.bottom.equalTo(contentView).inset(5)
            $0.height.equalTo(70)
        }
        
        friendUserImage.snp.makeConstraints {
            $0.width.height.equalTo(40)
            $0.centerY.equalTo(mainView)
            $0.left.equalTo(mainView).offset(15)
        }
        friendNameLabel.snp.makeConstraints {
            $0.centerY.equalTo(mainView)
            $0.left.equalTo(friendUserImage.snp.right).offset(10)
            $0.height.equalTo(24)
        }
    }
    
}
