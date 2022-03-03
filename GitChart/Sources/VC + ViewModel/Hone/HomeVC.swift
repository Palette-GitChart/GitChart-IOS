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
    
    private let profileView = UIView()
    private let dayCommitView = UIView()
    private let weekCommitView = UIView()
    private let commitGoalView = UIView()
    private let commitChartView = UIView()
    
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
    
    
    override func configureUI() {
        self.title = "Home"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        cellViewMake()
    }
    
    override func setupConstraints() {
        scrollView.snp.makeConstraints { $0.edges.equalTo(view) }
        contentView.snp.makeConstraints {
            $0.top.bottom.equalTo(scrollView)
            $0.left.right.equalTo(view)
        }
        profileView.snp.makeConstraints {
            $0.left.right.equalTo(contentView).inset(15)
            $0.top.equalTo(contentView).offset(5)
            $0.bottom.equalTo(-5)
            $0.height.equalTo(100)
        }
    }
}
