//
//  FriendsDetailVC.swift
//  GitChart
//
//  Created by 김대희 on 2022/03/14.
//

import UIKit
import SafariServices

class FriendsDetailVC : BaseViewController {
    
    var githubURL = ""
    let viewModel = FriendsDetailViewModel()
    
    let friendProfile = UIImageView().then {
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 50
        $0.layer.borderWidth = 0.5
        $0.layer.borderColor = UIColor.secondaryLabel.cgColor
    }
    
    let friendTitlelabel = UILabel().then {
        $0.textColor = .appColor(.labelColor)
        $0.font = .roundedFont(ofSize: 25, weight: .semibold)
        $0.textAlignment = .center
    }
    
    let visitWebButton = UIButton().then {
        $0.setTitle("Web에서 보기", for: .normal)
        $0.backgroundColor = UIColor(rgb: 0x67C58E).withAlphaComponent(0.9)
        $0.titleLabel?.textColor = .white
        $0.titleLabel?.font = .notoFont(size: .Regular, ofSize: 22)
        $0.layer.cornerRadius = 15
    }
    
    let followerLabel = UILabel().then {
        $0.textAlignment = .right
    }
    let followingLabel = UILabel().then {
        $0.textAlignment = .left
    }
    
    let dayCommitView = UIView()
    let yearCommitView = UIView()
    
    let dayCommitLabel = UILabel()
    let yearCommitLabel = UILabel()
    
    let dayCommitCountLabel = UILabel()
    let yearCommitCountLabel = UILabel()
    
    func makeCommitView() {
        let commitView = [dayCommitView, yearCommitView]
        let commitLabel = [dayCommitLabel, yearCommitLabel]
        commitView.forEach {
            $0.backgroundColor = .appColor(.cellColor)
            $0.layer.cornerRadius = 20
        }
        commitLabel.forEach {
            $0.font = .roundedFont(ofSize: 20, weight: .semibold)
            $0.textColor = .appColor(.labelColor)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
        self.tabBarController?.tabBar.isTranslucent = true // <- 이코드가 꼭 있어야함
        
    }
    
    override func configureUI() {
        navigationItem.largeTitleDisplayMode = .never
        self.navigationController?.navigationBar.tintColor = .appColor(.mainColor)
        makeCommitView()
        
        dayCommitLabel.text = "Today Commit"
        yearCommitLabel.text = "Year Commit"
        
        [friendProfile, friendTitlelabel, followerLabel, followingLabel, dayCommitView, yearCommitView, visitWebButton].forEach {
            view.addSubview($0)
        }
        
        [dayCommitLabel, dayCommitCountLabel].forEach {
            dayCommitView.addSubview($0)
        }
        
        [yearCommitLabel, yearCommitCountLabel].forEach {
            yearCommitView.addSubview($0)
        }
        bindViewModel()
        visitWebButton.rx.tap.bind {
            let safariViewController = SFSafariViewController(url: URL(string: self.githubURL)!)
            safariViewController.modalPresentationStyle = .overFullScreen
            self.present(safariViewController, animated: true, completion: nil)
        }.disposed(by: disposeBag)
    }
    
    override func setupConstraints() {
        friendProfile.snp.makeConstraints {
            $0.width.height.equalTo(100)
            $0.centerX.equalTo(view)
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
        }
        friendTitlelabel.snp.makeConstraints {
            $0.height.equalTo(40)
            $0.centerX.equalTo(view)
            $0.top.equalTo(friendProfile.snp.bottom).offset(10)
        }
        
        followerLabel.snp.makeConstraints {
            $0.height.equalTo(30)
            $0.top.equalTo(friendTitlelabel.snp.bottom).offset(10)
            $0.right.equalTo(view.snp.centerX).offset(-10)
            $0.left.equalTo(10)
        }
        followingLabel.snp.makeConstraints {
            $0.height.equalTo(30)
            $0.top.equalTo(friendTitlelabel.snp.bottom).offset(10)
            $0.left.equalTo(view.snp.centerX).offset(10)
            $0.right.equalTo(-10)
        }
        visitWebButton.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(5)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(10)
            $0.height.equalTo(50)
        }
        
        dayCommitView.snp.makeConstraints {
            $0.left.right.equalTo(view).inset(15)
            $0.top.equalTo(followingLabel.snp.bottom).offset(15)
            $0.height.equalTo(135)
        }
        yearCommitView.snp.makeConstraints {
            $0.left.right.equalTo(view).inset(15)
            $0.top.equalTo(dayCommitView.snp.bottom).offset(15)
            $0.height.equalTo(135)
        }
        
        [dayCommitLabel, yearCommitLabel].forEach { view in
            view.snp.makeConstraints {
                $0.top.left.equalTo(15)
                $0.height.equalTo(20)
            }
        }
        [dayCommitCountLabel, yearCommitCountLabel].forEach { view in
            view.snp.makeConstraints {
                $0.right.bottom.equalTo(-15)
            }
            
        }
    }
    
    func bindViewModel() {
        let output = viewModel.trans(.init(username: self.friendTitlelabel.text ?? ""))
        
        output.getUserProfile.bind { user in
            self.followingLabel.text = "팔로잉 \(user.following.dsecimalNumber())명"
            self.followerLabel.text = "팔로워 \(user.followers.dsecimalNumber())명"
            
        }.disposed(by: disposeBag)
        
        output.getDayCommit.bind { number in
            self.dayCommitCountLabel.makeCommitCountLabel(UIColor(rgb: 0x6EC7CD)
                .withAlphaComponent(0.98))
            self.dayCommitCountLabel.text = "\(number)개"
        }.disposed(by: disposeBag)
        
        output.getYearCommit.bind { number in
            self.yearCommitCountLabel.makeCommitCountLabel(UIColor(rgb:0xFF7865)
                .withAlphaComponent(0.71))
            self.yearCommitCountLabel.text = "\(number.dsecimal())개"
        }.disposed(by: disposeBag)
    }
}
