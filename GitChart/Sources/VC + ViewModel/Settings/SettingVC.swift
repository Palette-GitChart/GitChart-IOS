//
//  SettingVC.swift
//  GitChart
//
//  Created by 김대희 on 2022/02/09.
//

import UIKit
import RxSwift

class SettingVC : BaseViewController {
    
    let settingTitleArray = ["Github 아이디 추가 변경", "일일 커밋 목표 수정하기", "개발자 소개", "오픈소스", "문의하기"]
    
    let mainTableView = UITableView().then {
        $0.register(SettingListCell.self, forCellReuseIdentifier: "settingListCell")
        $0.backgroundColor = .clear
        $0.separatorStyle = .none
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.appColor(.labelColor), .font : UIFont.roundedFont(ofSize: 20, weight: .semibold)]
        mainTableView.reloadData()
    }
    
    override func configureUI() {
        self.title = "Setting"
        view.addSubview(mainTableView)
        mainTableView.delegate = self
        mainTableView.dataSource = self
    }
    
    override func setupConstraints() {
        mainTableView.snp.makeConstraints { $0.edges.equalToSuperview() }
    }
}

extension SettingVC : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = indexPath.row
        switch row {
        case 0:
            return SettingHeaderCell()
        case 1, 2, 3, 4, 5:
            let cell = tableView.dequeueReusableCell(withIdentifier: "settingListCell") as! SettingListCell
            cell.textLabbel.text = settingTitleArray[row-1]
            return cell
        case 6:
            return VersionCell()
        default:
            return UITableViewCell()
        }
    }
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        if indexPath.row == 1 {
            self.present(AddUserNameVC(), animated: true)
        }
        return indexPath
    }
}
