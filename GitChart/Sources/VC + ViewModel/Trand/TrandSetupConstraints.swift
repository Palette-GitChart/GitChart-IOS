//
//  TrandSetupConstraints.swift
//  GitChart
//
//  Created by 김대희 on 2022/03/15.
//

import Foundation

extension TrandVC {
    func setupConstraint() {
        scrollView.snp.makeConstraints { $0.edges.equalTo(view) }
        contentView.snp.makeConstraints { $0.edges.width.equalTo(self.scrollView) }
    }
}
