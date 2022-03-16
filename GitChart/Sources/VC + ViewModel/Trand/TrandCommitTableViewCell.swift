//
//  TrandCommitTableViewCell.swift
//  GitChart
//
//  Created by 김대희 on 2022/03/15.
//

import UIKit

class TrandCommitTableViewCell: BaseTableViewCell {
    
    let mainView = UIView()
    
    let mounthCommitView = UIView()
    let yearCommitView = UIView()
    
    let mounthCommitLabel = UILabel()
    let yearComitLabel = UILabel()
    
    let mountCommitCountLabel = UILabel()
    let yearCommitCountLabel = UILabel()
    
    func makeView() {
        
        mainView.backgroundColor = .clear
        
        [mounthCommitView, yearCommitView].forEach {
            $0.backgroundColor = .appColor(.cellColor)
            $0.layer.cornerRadius = 20
            
        }
        
        [mounthCommitLabel, yearComitLabel].forEach {
            $0.font = .roundedFont(ofSize: 20, weight: .semibold)
            $0.textColor = .appColor(.labelColor)
        }
        
    }
    
    override func configureUI() {
        contentView.backgroundColor = .appColor(.backgroundColor)
        contentView.addSubview(mainView)
        mounthCommitLabel.text = "Mounth Commit"
        yearComitLabel.text = "Year Commit"
        [mounthCommitView, yearCommitView].forEach {
            mainView.addSubview($0)
        }
        [mounthCommitLabel, mountCommitCountLabel].forEach {
            mounthCommitView.addSubview($0)
        }
        [yearComitLabel, yearCommitCountLabel].forEach {
            yearCommitView.addSubview($0)
        }
        makeView()
    }
    
    override func setupConstraints() {
        mainView.snp.makeConstraints { $0.edges.equalTo(0) }
        
        mounthCommitLabel.snp.makeConstraints {
            $0.top.left.bottom.equalTo(mainView).inset(15)
            $0.right.equalTo(mainView.snp.center).inset(7.5)
        }
        yearCommitView.snp.makeConstraints {
            $0.top.right.bottom.equalTo(mainView).inset(15)
            $0.left.equalTo(mainView.snp.center).offset(7.5)
        }
        
        [mounthCommitLabel, yearComitLabel].forEach { view in
            view.snp.makeConstraints {
                $0.top.left.equalTo(15)
                $0.height.equalTo(30)
            }
        }
        [mountCommitCountLabel, yearCommitCountLabel].forEach { label in
            label.snp.makeConstraints {
                $0.right.bottom.equalTo(-15)
                $0.height.equalTo(40)
            }
        }
    }
}
