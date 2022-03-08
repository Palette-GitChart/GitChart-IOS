//
//  trandChart.swift
//  GitChart
//
//  Created by 김대희 on 2022/03/08.
//

import Foundation
import Charts

extension HomeVC {
    func makeTrandChart(commitArray : [Double]) {
        
        trandChart.noDataText = "Loading Data"
        trandChart.setScaleEnabled(false)
        
        trandChart.drawGridBackgroundEnabled = false
        trandChart.xAxis.drawAxisLineEnabled = false
        trandChart.xAxis.drawLimitLinesBehindDataEnabled = false
        trandChart.xAxis.gridColor = .appColor(.mainColor)
        trandChart.xAxis.gridLineWidth = 0.5
        trandChart.xAxis.drawGridLinesEnabled = false
        trandChart.xAxis.drawLabelsEnabled = false
        trandChart.animate(xAxisDuration: 0.5)
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
        
        
        let linechart1 = LineChartDataSet(entries: lineChartEntry, label: "")
        
        let gradient = getGradientFilling()
        
        
        for i in 0..<commitDay.count {
            let dataEntry = ChartDataEntry(x: Double(i), y: commitDay[i])
            lineChartEntry.append(dataEntry)
        }
                
        linechart1.highlightEnabled = false
        linechart1.lineWidth = 2.0
        linechart1.fill = Fill.fillWithLinearGradient(gradient, angle: 90.0)
        linechart1.drawFilledEnabled = true
        linechart1.drawCirclesEnabled = false
        linechart1.drawValuesEnabled = false
        linechart1.mode = .cubicBezier
        linechart1.colors = [NSUIColor(rgb: 0x7FC567)]
        linechart1.cubicIntensity = 0.2
        
        let data = LineChartData()
        data.addDataSet(linechart1)
        trandChart.data = data
    }
    func getGradientFilling() -> CGGradient {
        // Setting fill gradient color
        let coloTop = UIColor(rgb: 0x7FC567).withAlphaComponent(0.64).cgColor
        let colorBottom = UIColor.appColor(.cellColor).cgColor
        // Colors of the gradient
        let gradientColors = [coloTop, colorBottom] as CFArray
        // Positioning of the gradient
        let colorLocations: [CGFloat] = [0.85, 0.0]
        // Gradient Object
        return CGGradient.init(colorsSpace: CGColorSpaceCreateDeviceRGB(), colors: gradientColors, locations: colorLocations)!
    }

}
