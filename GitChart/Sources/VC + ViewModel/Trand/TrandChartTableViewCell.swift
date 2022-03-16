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
}

