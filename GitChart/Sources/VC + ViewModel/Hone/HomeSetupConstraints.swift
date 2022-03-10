//
//  HomeSetupConstraints.swift
//  GitChart
//
//  Created by 김대희 on 2022/03/08.
//

import Foundation
import SnapKit

extension HomeVC {
    func setupConstraint() {
        scrollView.snp.makeConstraints { $0.edges.equalTo(view) }
        contentView.snp.makeConstraints { $0.edges.width.equalTo(self.scrollView) }
        
        // profileCell
        
        profileView.snp.makeConstraints {
            $0.left.right.equalTo(contentView).inset(15)
            $0.top.equalTo(contentView).offset(5)
            $0.height.equalTo(100)
        }
        profileImage.snp.makeConstraints {
            $0.centerY.equalTo(profileView)
            $0.leading.equalTo(10)
            $0.width.height.equalTo(80)
        }
        profilenName.snp.makeConstraints {
            $0.height.equalTo(30)
            $0.top.equalTo(20)
            $0.leading.equalTo(profileImage.snp.trailing).offset(20)
            $0.trailing.equalTo(profileView.snp.trailing).inset(10)
        }
        profileDetail.snp.makeConstraints {
            $0.top.equalTo(profilenName.snp.bottom)
            $0.height.equalTo(30)
            $0.leading.equalTo(profileImage.snp.trailing).offset(20)
            $0.trailing.equalTo(profileView.snp.trailing).inset(10)
        }
        
        // commitCountView
        
        commitView1.snp.makeConstraints {
            $0.top.equalTo(profileView.snp.bottom).offset(10)
            $0.left.equalTo(contentView).inset(15)
            $0.right.equalTo(contentView.snp.centerX).offset(-7.5)
            $0.height.equalTo(135)
        }
        
        commitView2.snp.makeConstraints {
            $0.top.equalTo(profileView.snp.bottom).offset(10)
            $0.left.equalTo(contentView.snp.centerX).offset(7.5)
            $0.right.equalTo(contentView).inset(15)
            $0.height.equalTo(135)
        }
        
        [commitLabel1, commitLabel2].forEach { label in
            label.snp.makeConstraints {
                $0.left.equalTo(15)
                $0.top.equalTo(15)
                $0.height.equalTo(20)
            }
        }
        
        [commitCountLabel1, commitCountLabel2].forEach { label in
            label.snp.makeConstraints {
                $0.right.bottom.equalTo(-15)
                $0.height.equalTo(40)
            }
        }
        
        // commitGoalView
        
        commitGoalView.snp.makeConstraints {
            $0.top.equalTo(commitView1.snp.bottom).offset(10)
            $0.left.right.equalTo(contentView).inset(15)
            $0.height.equalTo(135)
        }
        
        commitGoalLabel.snp.makeConstraints {
            $0.top.equalTo(15)
            $0.left.right.equalTo(commitGoalView).inset(15)
            $0.height.equalTo(30)
        }
        
        commitGoalProgressView.snp.makeConstraints {
            $0.top.equalTo(commitGoalLabel.snp.bottom).offset(15)
            $0.left.right.equalTo(commitGoalView).inset(15)
            $0.height.equalTo(15)
        }
        [commitGoalCountLabel1, commitGoalCountLabel2].forEach { label in
            label.snp.makeConstraints {
                $0.top.equalTo(commitGoalProgressView.snp.bottom).offset(10)
                $0.left.right.equalTo(commitGoalView).inset(15)
                $0.height.equalTo(15)
            }
        }
        
        // commitTrandView
        
        commitTrandView.snp.makeConstraints {
            $0.top.equalTo(commitGoalView.snp.bottom).offset(10)
            $0.left.right.equalTo(contentView).inset(15)
            $0.height.equalTo(280)
            $0.bottom.equalTo(-10)
        }
        
        commitTrandLabel.snp.makeConstraints {
            $0.top.equalTo(15)
            $0.left.right.equalTo(commitTrandView).inset(15)
            $0.height.equalTo(30)
        }
        
        [commitTrandCountLabel1, commitTrandCountLabel2].forEach { label in
            label.snp.makeConstraints {
                $0.bottom.equalTo(-15)
                $0.left.right.equalTo(commitTrandView).inset(15)
                $0.height.equalTo(15)
            }
        }
        
        trandChart.snp.makeConstraints {
            $0.top.equalTo(commitTrandLabel.snp.bottom).offset(5)
            $0.bottom.equalTo(commitTrandCountLabel2.snp.top).offset(-5)
            $0.left.right.equalTo(commitTrandView).inset(15)
        }
        
    }
    
}
