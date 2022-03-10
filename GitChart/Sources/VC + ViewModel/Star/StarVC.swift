//
//  StarVC.swift
//  GitChart
//
//  Created by 김대희 on 2022/02/09.
//

import UIKit

class StarVC : BaseViewController {
    
    let mainTableView = UITableView().then {
        $0.backgroundColor = .clear
        $0.separatorStyle = .none
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.appColor(.labelColor), .font : UIFont.roundedFont(ofSize: 20, weight: .semibold)]
        self.navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor: UIColor.appColor(.labelColor), .font : UIFont.roundedFont(ofSize: 34, weight: .bold)]
    }
    
    override func configureUI() {
        self.title = "Star"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationBar.sizeToFit()
        view.addSubview(mainTableView)
    }
    
    override func setupConstraints() {
        mainTableView.snp.makeConstraints { $0.edges.equalToSuperview() }
    }
}
