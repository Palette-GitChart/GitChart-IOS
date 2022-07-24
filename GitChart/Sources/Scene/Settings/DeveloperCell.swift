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
    
    let userImage = UIImageView().then {
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 25
        $0.layer.borderWidth = 0.5
        $0.layer.borderColor = UIColor.secondaryLabel.cgColor
        $0.contentMode = .scaleAspectFill
    }
    
    let nameLabel = UILabel().then {
        $0.font = .roundedFont(ofSize: 20, weight: .medium)
        $0.textColor = .label
    }
    
    let descriptionlabel = UILabel().then {
        $0.font = .roundedFont(ofSize: 14, weight: .medium)
        $0.textColor = .appColor(.labelColor)
    }
    
    let portfolioImage = UIImageView()
    
    override func configureUI() {
        contentView.backgroundColor = .appColor(.backgroundColor)
        contentView.addSubview(mainView)
        [userImage, nameLabel, descriptionlabel, portfolioImage].forEach {
            mainView.addSubview($0)
        }
    }
    
    override func setupConstraints() {
        mainView.snp.makeConstraints {
            $0.top.bottom.equalTo(contentView).inset(5)
            $0.leading.trailing.equalTo(contentView).inset(15)
            $0.height.equalTo(100)
        }
        userImage.snp.makeConstraints {
            $0.width.height.equalTo(50)
            $0.centerY.equalTo(mainView)
            $0.left.equalTo(10)
        }
        
        nameLabel.snp.makeConstraints {
            $0.top.equalTo(30)
            $0.height.equalTo(20)
            $0.left.equalTo(userImage.snp.right).offset(20)
        }
        descriptionlabel.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom)
            $0.height.equalTo(20)
            $0.left.equalTo(userImage.snp.right).offset(20)
        }
        
        portfolioImage.snp.makeConstraints {
            $0.width.height.equalTo(40)
            $0.right.equalTo(-20)
            $0.centerY.equalTo(mainView)
        }
    }
}
