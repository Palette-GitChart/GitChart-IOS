//
//  BaseTableViewCell.swift
//  GitChart
//
//  Created by 김대희 on 2022/03/10.
//

import Foundation
import UIKit
import SnapKit
import Then

class BaseTableViewCell: UITableViewCell {
    // MARK: - Initializing
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.configureUI()
        self.setupConstraints()
        self.initialize()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initialize() {
        
    }
    
    func configureUI() {
        
    }
    
    func setupConstraints() {
        // Override point
    }
}
