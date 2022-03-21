//
//  SettingListCell.swift
//  GitChart
//
//  Created by 김대희 on 2022/03/21.
//

import UIKit

class SettingListCell : BaseTableViewCell {
    
    let mainView = UIView().then {
        $0.backgroundColor = .appColor(.cellColor)
    }
    
    let textLabbel = UILabel().then {
        $0.textColor = .appColor(.labelColor)
        $0.font = .notoFont(size: .Regular, ofSize: 18)
    }
    
    let rightCistomImage = UIImageView().then {
        $0.image = UIImage(systemName: "chevron.right")
        $0.tintColor = .appColor(.mainColor)
    }
    
    override func configureUI() {
        contentView.backgroundColor = .appColor(.backgroundColor)
        contentView.addSubview(mainView)
        [textLabbel, rightCistomImage].forEach {
            mainView.addSubview($0)
        }
    }
    
    override func setupConstraints() {
        mainView.snp.makeConstraints {
            $0.top.bottom.equalTo(contentView).inset(2.5)
            $0.leading.trailing.equalTo(contentView).inset(15)
            $0.height.equalTo(50)
        }
        textLabbel.snp.makeConstraints {
            $0.centerY.equalTo(mainView)
            $0.height.equalTo(20)
            $0.left.equalTo(20)
        }
        rightCistomImage.snp.makeConstraints {
            $0.width.height.equalTo(28)
            $0.centerY.equalTo(mainView)
            $0.right.equalTo(-10)
        }
    }
}
