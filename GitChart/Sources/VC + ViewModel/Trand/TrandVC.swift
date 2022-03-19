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
        let output = viewModel.trans(.init(username: "kimdaehee0824"))
        
        output.getMounthCommit.bind { count in
            self.mounthCommitCount.accept(count)
        }.disposed(by: disposeBag)
        
        output.getYearCommit.bind { count in
            self.yearCommitCount.accept(count)
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
            let commitLabelArray = ["Mounth Commit", "Year Commit"]
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
            return TrandChartTableViewCell()
        }
        else { return UITableViewCell() }
        
    }
}
