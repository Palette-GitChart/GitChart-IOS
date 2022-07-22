//
//  TrandCommitTableViewCell.swift
//  GitChart
//
//  Created by 김대희 on 2022/03/15.
//

import UIKit

class TrandCommitTableViewCell: BaseTableViewCell {
    
    let mainView = UIView()
    
    let commitView = UIView().then {
        $0.backgroundColor = .appColor(.cellColor)
        $0.layer.cornerRadius = 20
        
    }
    let commitLabel = UILabel().then {
        $0.font = .roundedFont(ofSize: 20, weight: .semibold)
        $0.textColor = .appColor(.labelColor)
    }
    
    let commitCountLabel = UILabel()
    
    override func configureUI() {
        contentView.backgroundColor = .appColor(.backgroundColor)
        mainView.backgroundColor = .clear
        contentView.addSubview(mainView)
        mainView.addSubview(commitView)
        
        [commitLabel, commitCountLabel].forEach {
            commitView.addSubview($0)
        }
    }
    
    override func setupConstraints() {
        mainView.snp.makeConstraints { $0.edges.equalTo(0) }
        
        commitView.snp.makeConstraints {
            $0.top.bottom.equalTo(mainView).inset(5)
            $0.left.right.equalTo(mainView).inset(15)
            $0.height.equalTo(135)
        }
        
        [commitLabel].forEach { view in
            view.snp.makeConstraints {
                $0.top.left.equalTo(15)
                $0.height.equalTo(30)
            }
        }
        [commitCountLabel].forEach { label in
            label.snp.makeConstraints {
                $0.right.bottom.equalTo(-15)
                $0.height.equalTo(40)
            }
        }
    }
}
