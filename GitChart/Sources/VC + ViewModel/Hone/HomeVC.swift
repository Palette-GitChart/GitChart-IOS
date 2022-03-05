//
//  HomeVC.swift
//  GitChart
//
//  Created by 김대희 on 2022/02/07.
//

import UIKit

class HomeVC : BaseViewController {
    
    private let scrollView = UIScrollView().then {
        $0.backgroundColor = .clear
        $0.showsVerticalScrollIndicator = false
    }
    
    private let contentView = UIView().then {
        $0.backgroundColor = .clear
    }
    
    //MARK: Cell View
    
    private let profileView = UIView()
    private let dayCommitView = UIView()
    private let weekCommitView = UIView()
    private let commitGoalView = UIView()
    private let commitChartView = UIView()
    
    //MARK: Cell in UI
    
    // profileView
    
    private let profileImage = UIImageView().then {
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 40
        $0.layer.borderWidth = 0.5
        $0.layer.borderColor = UIColor.secondaryLabel.cgColor
    }
    
    private let profilenName = UILabel().then {
        $0.font = .roundedFont(ofSize: 25, weight: .medium)
        $0.textColor = .appColor(.labelColor)
    }
    
    private let profileDetail = UILabel().then {
        $0.font = .notoFont(size: .Regular, ofSize: 15)
        $0.textColor = .appColor(.labelColor)
    }
    
    // dayCommitView
    
    let commitLabel1 = UILabel()
    let commitLabel2 = UILabel()
    
    let commitCountLabel1 = UILabel()
    let commitCountLabel2 = UILabel()
    
    func makeDayCommitView() {
        let commitLabelArray = [commitLabel1, commitLabel2, ]
        let commitCountLabelArray = [commitCountLabel1, commitCountLabel2]
        for main in 0...2 {
            print(main)
            commitLabelArray[main].font = .roundedFont(ofSize: 20, weight: .semibold)
            commitCountLabelArray[main].font = .roundedFont(ofSize: 40, weight: .medium)
        }
    }
    
    
    func cellViewMake() {
        [profileView, dayCommitView, weekCommitView, commitGoalView, commitChartView]
            .forEach { v in
                v.backgroundColor = UIColor.appColor(.cellColor)
                v.layer.cornerRadius = 20
                contentView.addSubview(v)
            }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.appColor(.mainColor), .font : UIFont.roundedFont(ofSize: 20, weight: .semibold)]
        self.navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor: UIColor.appColor(.mainColor), .font : UIFont.roundedFont(ofSize: 34, weight: .bold)]
        
    }
    
    //MARK: - configure
    
    override func configureUI() {
        self.title = "Home"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        cellViewMake()
        
        [profileImage, profilenName, profileDetail].forEach {
            profileView.addSubview($0)
        }
        [commitLabel1, commitLabel2].forEach {
            dayCommitView.addSubview($0)
        }
        [commitLabel2, commitLabel2].forEach {
            weekCommitView.addSubview($0)
        }
        
        //TODO: dummy 추후 변경 예정
        
        profileImage.image = UIImage(named: "profiedaeheeKim")
        profilenName.text = "kimdaehee0824"
        profileDetail.text = "팔로워 67명 | 팔로우 29명"
        
    }
    
    override func setupConstraints() {
        scrollView.snp.makeConstraints { $0.edges.equalTo(view) }
        contentView.snp.makeConstraints {
            $0.top.bottom.equalTo(scrollView)
            $0.left.right.equalTo(view)
        }
        
        // profileCell
        
        profileView.snp.makeConstraints {
            $0.left.right.equalTo(contentView).inset(15)
            $0.top.equalTo(contentView).offset(5)
            $0.bottom.equalTo(-5)
            $0.height.equalTo(100)
        }
        profileImage.snp.makeConstraints {
            $0.centerY.equalTo(profileView)
            $0.leading.equalTo(10)
            $0.width.height.equalTo(80)
        }
        profilenName.snp.makeConstraints {
            $0.height.equalTo(30)
            $0.top.equalTo(20)
            $0.leading.equalTo(profileImage.snp.trailing).offset(20)
            $0.trailing.equalTo(profileView.snp.trailing).inset(10)
        }
        profileDetail.snp.makeConstraints {
            $0.top.equalTo(profilenName.snp.bottom)
            $0.height.equalTo(30)
            $0.leading.equalTo(profileImage.snp.trailing).offset(20)
            $0.trailing.equalTo(profileView.snp.trailing).inset(10)
        }
        
    }
}
