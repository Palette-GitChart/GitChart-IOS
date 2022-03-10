//
//  StarListTableViewCell.swift
//  GitChart
//
//  Created by 김대희 on 2022/03/10.
//

import UIKit


class StarListTableViewCell: BaseTableViewCell {
    
    let mainView = UIView().then {
        $0.backgroundColor = .appColor(.cellColor)
        $0.layer.cornerRadius = 20
    }
    
    let starTitleLabel = UILabel().then {
        $0.font = .roundedFont(ofSize: 22, weight: .medium)
        $0.textColor = .appColor(.labelColor)
    }
    
    let starDetailLabel = UILabel().then {
        $0.font = .roundedFont(ofSize: 12, weight: .medium)
        $0.textColor = .appColor(.labelColor)
    }
    
    let starUserImage = UIImageView().then {
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 20
        $0.layer.borderWidth = 0.5
        $0.layer.borderColor = UIColor.secondaryLabel.cgColor
    }
    
    override func configureUI() {
        contentView.backgroundColor = .appColor(.backgroundColor)
        contentView.addSubview(mainView)
        [starUserImage, starTitleLabel, starDetailLabel].forEach { mainView.addSubview($0) }
    }
    
    override func setupConstraints() {
        mainView.snp.makeConstraints {
            $0.left.right.equalTo(contentView).inset(15)
            $0.top.equalTo(contentView).offset(5)
            $0.bottom.equalTo(contentView).inset(15)
            $0.height.equalTo(80)
        }
        starUserImage.snp.makeConstraints {
            $0.width.height.equalTo(40)
            $0.centerY.equalTo(mainView)
            $0.right.equalTo(mainView).inset(15)
        }
        starTitleLabel.snp.makeConstraints {
            $0.top.left.equalTo(20)
            $0.right.equalTo(starUserImage.snp.left).inset(10)
            $0.height.equalTo(20)
        }
        starDetailLabel.snp.makeConstraints {
            $0.top.equalTo(starTitleLabel.snp.bottom).offset(5)
            $0.left.equalTo(20)
        }
    }
    
}
