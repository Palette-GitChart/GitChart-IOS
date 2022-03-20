//
//  TrandChartTableViewCell.swift
//  GitChart
//
//  Created by 김대희 on 2022/03/15.
//

import UIKit
import Charts

class TrandChartTableViewCell: BaseTableViewCell {
    
    let mainView = UIView().then {
        $0.backgroundColor = .clear
    }
    
    let trandView = UIView().then {
        $0.backgroundColor = .appColor(.cellColor)
        $0.layer.cornerRadius = 20
    }
    
    var titleLabel = UILabel().then {
        $0.font = .roundedFont(ofSize: 20, weight: .semibold)
        $0.textColor = .appColor(.labelColor)
    }
    
    let  commitChart = LineChartView()
    
    override func configureUI() {
        
        contentView.backgroundColor = .appColor(.backgroundColor)
        contentView.addSubview(mainView)
        mainView.addSubview(trandView)
        [titleLabel, commitChart].forEach { trandView.addSubview($0)}
        makeChart()
    }
    
    override func setupConstraints() {
        mainView.snp.makeConstraints { $0.edges.equalTo(0) }
        
        trandView.snp.makeConstraints {
            $0.top.bottom.equalTo(mainView).inset(5)
            $0.left.right.equalTo(mainView).inset(15)
            $0.height.equalTo(240)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.left.equalTo(15)
            $0.height.equalTo(30)
        }
        commitChart.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(5)
            $0.bottom.equalTo(mainView).offset(-15)
            $0.left.right.equalTo(mainView).inset(15)
        }
    }
    
}

//MARK: - Charts Settinga

extension TrandChartTableViewCell {
    func makeChart() {
        
        commitChart.noDataText = "Loading Data"
        commitChart.setScaleEnabled(false)
        commitChart.drawGridBackgroundEnabled = false
        commitChart.legend.enabled = false
        
        commitChart.xAxis.drawAxisLineEnabled = false
        commitChart.xAxis.drawLimitLinesBehindDataEnabled = false
        commitChart.xAxis.gridColor = .appColor(.mainColor)
        commitChart.xAxis.gridLineWidth = 0.5
        commitChart.xAxis.drawGridLinesEnabled = false
        commitChart.xAxis.drawLabelsEnabled = false
        commitChart.xAxis.drawGridLinesEnabled = false
        
        commitChart.leftAxis.drawLabelsEnabled = false
        commitChart.leftAxis.removeAllLimitLines()
        commitChart.leftAxis.drawZeroLineEnabled = false
        commitChart.leftAxis.zeroLineWidth = 0
        commitChart.leftAxis.drawTopYLabelEntryEnabled = false
        commitChart.leftAxis.drawAxisLineEnabled = false
        commitChart.leftAxis.drawGridLinesEnabled = false
        commitChart.leftAxis.drawLabelsEnabled = false
        commitChart.leftAxis.drawLimitLinesBehindDataEnabled = false
        
        commitChart.rightAxis.removeAllLimitLines()
        commitChart.rightAxis.drawZeroLineEnabled = false
        commitChart.rightAxis.drawTopYLabelEntryEnabled = false
        commitChart.rightAxis.drawAxisLineEnabled = false
        commitChart.rightAxis.drawGridLinesEnabled = false
        commitChart.rightAxis.drawLabelsEnabled = false
        commitChart.rightAxis.drawLimitLinesBehindDataEnabled = false
    }
    
    func setChartTrand(bar :BarChartDataSet ) {
        bar.drawValuesEnabled = false
        bar.highlightEnabled = false
    }
}

