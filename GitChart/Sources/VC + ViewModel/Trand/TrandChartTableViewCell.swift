//
//  TrandChartTableViewCell.swift
//  GitChart
//
//  Created by 김대희 on 2022/03/15.
//

import UIKit

class TrandChartTableViewCell: BaseTableViewCell {
    
    let mainView = UIView().then {
        $0.backgroundColor = .appColor(.cellColor)
        $0.layer.cornerRadius = 20
    }
    
    var titleLabel = UILabel().then {
        $0.font = .roundedFont(ofSize: 20, weight: .semibold)
        $0.textColor = .appColor(.labelColor)
    }
    
    override func configureUI() {
        contentView.backgroundColor = .appColor(.backgroundColor)
    }
}
