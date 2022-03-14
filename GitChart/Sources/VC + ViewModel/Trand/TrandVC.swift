//
//  TrandVC.swift
//  GitChart
//
//  Created by 김대희 on 2022/03/14.
//

import UIKit
import Charts

class TrandVC : BaseViewController {
    
    let scrollView = UIScrollView().then {
        $0.backgroundColor = .clear
    }
    
    let contentView = UIView().then {
        $0.backgroundColor = .clear
    }
    
    let mounthCommitView = UIView()
    let yearCommitView = UIView()
    
    let mounthCommitLabel = UILabel()
    let yearCommitLabel = UILabel()
    
    let mounthCommitCountLabel = UILabel()
    let yearCommitCountLabel = UILabel()
    
    let weekChartView = UIView()
    let mounthChartView = UIView()
    let yearChartView = UIView()
    
    let weekChartLabel = UILabel()
    let mounthChartLabel = UILabel()
    let yearChartLabel = UILabel()
    
    let weekChart = LineChartView()
    let mountChart = LineChartView()
    let yearChart = BarChartView()
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
        self.tabBarController?.tabBar.isTranslucent = true // <- 이코드가 꼭 있어야함
        
        [mounthCommitView, yearCommitView, weekChartView, mounthChartView, yearChartView].forEach {
            view.addSubview($0)
        }
        [mounthCommitLabel, mounthCommitCountLabel].forEach {
            mounthCommitView.addSubview($0)
        }
        [yearCommitLabel, yearCommitCountLabel].forEach {
            yearCommitView.addSubview($0)
        }
        [weekChartLabel, weekChart].forEach {
            weekChartView.addSubview($0)
        }
        [mounthChartLabel, mountChart].forEach {
            mounthChartView.addSubview($0)
        }
        [yearChartLabel, yearChart].forEach {
            yearChartView.addSubview($0)
        }
    }
    
    override func configureUI() {
        navigationItem.largeTitleDisplayMode = .never
        self.navigationController?.navigationBar.tintColor = .appColor(.mainColor)
    }
}
