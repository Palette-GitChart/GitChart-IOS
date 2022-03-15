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
}
