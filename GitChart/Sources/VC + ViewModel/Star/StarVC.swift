//
//  StarVC.swift
//  GitChart
//
//  Created by 김대희 on 2022/02/09.
//

import UIKit
import Kingfisher

class StarVC : BaseViewController {
    
    let viewModel = StarViewModwl()
    
    let mainTableView = UITableView().then {
        $0.register(StarListTableViewCell.self, forCellReuseIdentifier: "starListCell")
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
    
    override func bindViewModel() {
        let output = viewModel.trans(.init(username: "kimdaehee0824"))

        output.getUserStarList
            .bind(to: mainTableView.rx
                    .items(cellIdentifier: "starListCell",
                           cellType: StarListTableViewCell.self)) {
                (index: Int, element: Starred, cell: StarListTableViewCell) in
                cell.starTitleLabel.text = element.name
                cell.starDetailLabel.text = "\(element.owner.login) - \(element.language ?? "no languge")"
                cell.starUserImage.kf.indicatorType = .activity
                cell.starUserImage.setImage(with: element.owner.avatar_url)
            }.disposed(by: disposeBag)
    }
}
