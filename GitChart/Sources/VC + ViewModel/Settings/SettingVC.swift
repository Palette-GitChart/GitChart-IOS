//
//  SettingVC.swift
//  GitChart
//
//  Created by 김대희 on 2022/02/09.
//

import UIKit

class SettingVC : BaseViewController {
    
    let mainTableView = UITableView().then {
        $0.backgroundColor = .clear
        $0.separatorStyle = .none
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.appColor(.labelColor), .font : UIFont.roundedFont(ofSize: 20, weight: .semibold)]
    }
    
    override func configureUI() {
        self.title = "Setting"
        view.addSubview(mainTableView)
    }
    
    override func setupConstraints() {
        mainTableView.snp.makeConstraints { $0.edges.equalToSuperview() }
    }
}
