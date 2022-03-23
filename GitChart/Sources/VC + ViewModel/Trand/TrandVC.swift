//
//  TrandVC.swift
//  GitChart
//
//  Created by 김대희 on 2022/03/14.
//

import UIKit
import RxRelay
import Charts

class TrandVC : BaseViewController {
    
    let viewModel = TrandViewModel()
    
    var mounthCommitCount = PublishRelay<String>()
    var yearCommitCount = PublishRelay<String>()
    
    var weekCommitArray = PublishRelay<[Int]>()
    var mounthCommitArray = PublishRelay<[Int]>()
    var yearCommitArray = PublishRelay<[Int]>()
    
    let mainTableView = UITableView().then {
        $0.register(TrandChartTableViewCell.self, forCellReuseIdentifier: "trandChartCell")
        $0.register(TrandCommitTableViewCell.self, forCellReuseIdentifier: "trandCommitCell")
        $0.backgroundColor = .clear
        $0.separatorStyle = .none
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
        self.tabBarController?.tabBar.isTranslucent = true // <- 이코드가 꼭 있어야함
    }
    
    override func configureUI() {
        navigationItem.largeTitleDisplayMode = .never
        self.navigationItem.title = "Trand"
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.appColor(.labelColor)]
        
        mainTableView.delegate = self
        mainTableView.dataSource = self
        self.navigationController?.navigationBar.sizeToFit()
        self.navigationController?.navigationBar.tintColor = .appColor(.mainColor)
        view.addSubview(mainTableView)
        bindViewModel()
    }
    
    override func setupConstraints() {
        mainTableView.snp.makeConstraints { $0.edges.equalToSuperview() }
    }
    func bindViewModel() {
        let output = viewModel.trans(.init(username: "이거 지금 사용 안함"))
        
        output.getMonthCommit.bind { count in
            self.mounthCommitCount.accept(count)
        }.disposed(by: disposeBag)
        
        output.getYearCommit.bind { count in
            self.yearCommitCount.accept(count)
        }.disposed(by: disposeBag)
        
        output.getWeekArray.bind { count in
            self.weekCommitArray.accept(count)
        }.disposed(by: disposeBag)
        
        output.getMounthArray.bind { count in
            self.mounthCommitArray.accept(count)
        }.disposed(by: disposeBag)
        
        output.getYearArray.bind { count in
            self.yearCommitArray.accept(count)
        }.disposed(by: disposeBag)
        
    }
}


extension TrandVC : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = indexPath.row
        
        if row == 0 || row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "trandCommitCell") as! TrandCommitTableViewCell
            let commitLabelArray = ["Month Commit", "Year Commit"]
            print(commitLabelArray[row])
            if indexPath.row == 0 {
                mounthCommitCount.bind { count in
                    cell.commitCountLabel.text = "\(count.dsecimal())개"
                    cell.commitCountLabel.makeCommitCountLabel(UIColor(rgb: 0xFFA903).withAlphaComponent(0.71))
                }.disposed(by: disposeBag)
            }
            if indexPath.row == 1 {
                yearCommitCount.bind { count in
                    cell.commitCountLabel.text = "\(count.dsecimal())개"
                    cell.commitCountLabel.makeCommitCountLabel(UIColor(rgb: 0xFF7865).withAlphaComponent(0.71))
                }.disposed(by: disposeBag)
            }
            cell.commitLabel.text = commitLabelArray[row]
            return cell
        }
        else if row >= 2 || 5 <= row {
            let trandRow = row - 2
            let trandLabelArray = ["Week Trand", "Month Trand", "Year Trand"]
            var dataEntries:  [BarChartDataEntry] = []
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "trandChartCell") as! TrandChartTableViewCell
            
            cell.titleLabel.text = trandLabelArray[trandRow]
            
            if trandRow == 0 {
                weekCommitArray.bind { array in
                    for i in 0..<array.count {
                        let dataEntry = BarChartDataEntry(x: Double(i), y: Double(array[i]))
                        dataEntries.append(dataEntry)
                    }
                    let chartDataSet = BarChartDataSet(entries: dataEntries, label: "")
                    chartDataSet.colors = [UIColor(rgb: 0x8071DA)]
                    
                    cell.setChartTrand(bar: chartDataSet)
                    let chartData = BarChartData(dataSet: chartDataSet)
                    
                    cell.commitChart.data = chartData
                    cell.commitChart.animate(xAxisDuration: 0.5)
                    
                }.disposed(by: disposeBag)
            }
            
            if trandRow == 1 {
                mounthCommitArray.bind { array in
                    for i in 0..<array.count {
                        let dataEntry = BarChartDataEntry(x: Double(i), y: Double(array[i]))
                        dataEntries.append(dataEntry)
                    }
                    
                    let chartDataSet = BarChartDataSet(entries: dataEntries, label: "")
                    chartDataSet.colors = [UIColor(rgb: 0xFFA903)]
                    let chartData = BarChartData()
                    cell.setChartTrand(bar: chartDataSet)
                    chartData.addDataSet(chartDataSet)
                    
                    cell.commitChart.data = chartData
                    cell.commitChart.animate(xAxisDuration: 0.5)
                    
                }.disposed(by: disposeBag)
                
            }
            if trandRow == 2 {
                yearCommitArray.bind { array in
                    for i in 0..<array.count {
                        let dataEntry = BarChartDataEntry(x: Double(i), y: Double(array[i]))
                        dataEntries.append(dataEntry)
                    }
                    
                    let chartDataSet = BarChartDataSet(entries: dataEntries, label: "")
                    chartDataSet.colors = [UIColor(rgb: 0xFF7865)]
                    let chartData = BarChartData()
                    cell.setChartTrand(bar: chartDataSet)
                    chartData.addDataSet(chartDataSet)
                    
                    cell.commitChart.data = chartData
                    cell.commitChart.animate(xAxisDuration: 0.5)
                    
                }.disposed(by: disposeBag)
                
                
            }
            return cell
        }
        else { return UITableViewCell() }
        
    }
}
