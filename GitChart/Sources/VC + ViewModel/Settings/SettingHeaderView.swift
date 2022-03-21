//
//  SettingHeaderView.swift
//  GitChart
//
//  Created by 김대희 on 2022/03/21.
//

import UIKit
import RxSwift
import RxCocoa
import RxRelay
import SnapKit
import Then

class SettingHeaderView: UITableViewHeaderFooterView {
    
    let mainView = UIView().then {
        $0.backgroundColor = .appColor(.cellColor)
        $0.layer.cornerRadius = 20
    }
    
    let userImage = UIImageView().then {
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 20
        $0.layer.borderWidth = 0.5
        $0.layer.borderColor = UIColor.secondaryLabel.cgColor
    }
    
    let nameLabel = UILabel().then {
        $0.font = .roundedFont(ofSize: 22, weight: .medium)
        $0.textColor = .appColor(.labelColor)
    }

    override func draw(_ rect: CGRect) {
        configureUI()
        setupConstraints()
    }
    
    func configureUI() {
        contentView.backgroundColor = .appColor(.backgroundColor)
        contentView.addSubview(mainView)
        nameLabel.text = "No Named"
        [userImage, nameLabel].forEach {
            mainView.addSubview($0)
        }
    }
    
    func setupConstraints() {
        mainView.snp.makeConstraints {
            $0.top.bottom.equalTo(contentView).inset(5)
            $0.leading.trailing.equalTo(contentView).inset(15)
            $0.height.equalTo(60)
        }
        userImage.snp.makeConstraints {
            $0.width.height.equalTo(40)
            $0.centerY.equalTo(mainView)
            $0.left.equalTo(mainView).offset(15)
        }
        nameLabel.snp.makeConstraints {
            $0.centerY.equalTo(mainView)
            $0.left.equalTo(userImage.snp.right).offset(10)
            $0.height.equalTo(20)
        }
    }
}
