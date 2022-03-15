//
//  TrandVC.swift
//  GitChart
//
//  Created by 김대희 on 2022/03/14.
//

import UIKit
import Charts

class TrandVC : BaseViewController {
    
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
        self.navigationController?.navigationBar.sizeToFit()
        self.navigationController?.navigationBar.tintColor = .appColor(.mainColor)
        view.addSubview(mainTableView)
    }
    
    override func setupConstraints() {
        mainTableView.snp.makeConstraints { $0.edges.equalToSuperview() }
    }
}
