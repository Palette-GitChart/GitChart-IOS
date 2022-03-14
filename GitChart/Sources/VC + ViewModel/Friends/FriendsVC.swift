//
//  FriendsVC.swift
//  GitChart
//
//  Created by 김대희 on 2022/02/09.
//

import UIKit

class FriendsVC : BaseViewController {
    
    let viewModel = FriendViewModel()
    
    let mainTableView = UITableView().then {
        $0.register(FriendsListTableViewCell.self, forCellReuseIdentifier: "friendsListCell")
        $0.backgroundColor = .clear
        $0.separatorStyle = .none
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.appColor(.labelColor), .font : UIFont.roundedFont(ofSize: 20, weight: .semibold)]
        self.navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor: UIColor.appColor(.labelColor), .font : UIFont.roundedFont(ofSize: 34, weight: .bold)]
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
        
    }
    
    
    override func configureUI() {
        self.title = "Friends"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        view.addSubview(mainTableView)
        bindViewModel()
    }
    
    override func setupConstraints() {
        mainTableView.snp.makeConstraints { $0.edges.equalTo(0) }
    }
    
    func bindViewModel() {
        let output = viewModel.trans(.init(username: "kimdaehee0824"))
        
        output.getUserFriendsList
            .bind(to: mainTableView.rx
                    .items(cellIdentifier: "friendsListCell",
                           cellType: FriendsListTableViewCell.self)) {
                (index: Int, element: Friends, cell: FriendsListTableViewCell) in
                cell.friendUserImage.kf.indicatorType = .activity
                cell.friendUserImage.setImage(with: element.avatar_url)
                cell.friendNameLabel.text = element.login
            }.disposed(by: disposeBag)

        mainTableView.rx.modelSelected(Friends.self).bind { element in
            let vc = FriendsDetailVC()
            self.navigationController?.pushViewController(vc, animated: true)
        }.disposed(by: disposeBag)

        
    }
}
