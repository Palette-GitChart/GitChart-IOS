//
//  trandChart.swift
//  GitChart
//
//  Created by 김대희 on 2022/03/08.
//

import Foundation
import Charts

extension HomeVC {
    func makeTrendChart() {
        
        trandChart.noDataText = "Loading Data"
        trandChart.setScaleEnabled(false)
        trandChart.drawGridBackgroundEnabled = false
        trandChart.xAxis.drawAxisLineEnabled = false
        trandChart.xAxis.drawLimitLinesBehindDataEnabled = false
        trandChart.xAxis.gridColor = .appColor(.mainColor)
        trandChart.xAxis.gridLineWidth = 0.5
        trandChart.xAxis.drawGridLinesEnabled = false
        trandChart.xAxis.drawLabelsEnabled = false
        
        trandChart.xAxis.drawGridLinesEnabled = false
        trandChart.leftAxis.drawLabelsEnabled = false
        trandChart.legend.enabled = false
        trandChart.leftAxis.removeAllLimitLines()
        trandChart.leftAxis.drawZeroLineEnabled = false
        trandChart.leftAxis.zeroLineWidth = 0
        trandChart.leftAxis.drawTopYLabelEntryEnabled = false
        trandChart.leftAxis.drawAxisLineEnabled = false
        trandChart.leftAxis.drawGridLinesEnabled = false
        trandChart.leftAxis.drawLabelsEnabled = false
        trandChart.leftAxis.drawLimitLinesBehindDataEnabled = false
        
        trandChart.rightAxis.removeAllLimitLines()
        trandChart.rightAxis.drawZeroLineEnabled = false
        trandChart.leftAxis.zeroLineWidth = 0
        trandChart.rightAxis.drawTopYLabelEntryEnabled = false
        trandChart.rightAxis.drawAxisLineEnabled = false
        trandChart.rightAxis.drawGridLinesEnabled = false
        trandChart.rightAxis.drawLabelsEnabled = false
        trandChart.rightAxis.drawLimitLinesBehindDataEnabled = false
    }
    
    
    func getGradientFilling(with rgb : Int, alpha: Double) -> CGGradient {
        // Setting fill gradient color
        let coloTop = UIColor(rgb: rgb).withAlphaComponent(alpha).cgColor
        let colorBottom = UIColor.appColor(.cellColor).cgColor
        // Colors of the gradient
        let gradientColors = [coloTop, colorBottom] as CFArray
        // Positioning of the gradient
        let colorLocations: [CGFloat] = [0.85, 0.0]
        // Gradient Object
        return CGGradient.init(colorsSpace: CGColorSpaceCreateDeviceRGB(), colors: gradientColors, locations: colorLocations)!
    }
    func setChartLine(line :LineChartDataSet, color : NSUIColor ) {
        line.drawFilledEnabled = true
        line.drawCirclesEnabled = false
        line.drawValuesEnabled = false
        line.highlightEnabled = false
        line.mode = .cubicBezier
        line.colors = [color]
        line.cubicIntensity = 0.2
        line.lineWidth = 2.0
        
    }

}
