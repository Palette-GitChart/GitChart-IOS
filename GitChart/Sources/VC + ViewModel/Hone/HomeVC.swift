//
//  HomeVC.swift
//  GitChart
//
//  Created by 김대희 on 2022/02/07.
//

import UIKit
import RxGesture

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
    private let commitView1 = UIView()
    private let commitView2 = UIView()
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
        
        let fontSize = UIFont.notoFont(size: .Regular, ofSize: 25)
        
        for main in 0..<2 {
            print(main)
            commitLabelArray[main].font = .roundedFont(ofSize: 20, weight: .semibold)
            commitLabelArray[main].textColor = .appColor(.labelColor)
            
            let str = commitCountLabelArray[main].text ?? ""
            
            let attributedStr = NSMutableAttributedString(string: commitCountLabelArray[main].text ?? "")
            let range = (str as NSString).range(of: "개")
            
            attributedStr.addAttribute(.font, value: fontSize, range: range)
            attributedStr.addAttribute(.foregroundColor, value: UIColor.appColor(.labelColor), range: range)
            
            commitCountLabelArray[main].font = .roundedFont(ofSize: 50, weight: .medium)
            commitCountLabelArray[main].attributedText = attributedStr
            
        }
    }
    
    //MARK: commit Goal View
    
    let commitGoalLabel = UILabel().then {
        $0.textColor = .appColor(.labelColor)
        $0.font = .roundedFont(ofSize: 20, weight: .semibold)
        $0.text = "Commit Goal"
    }
    
    let commitGoalProgressView = UIProgressView().then {
        $0.progressTintColor = UIColor(rgb: 0x7FC567)
        $0.trackTintColor = UIColor(named: "progressTrackColor")
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 7.5
        $0.layer.sublayers![1].cornerRadius = 7.5// 뒤에 있는 회색 track
        $0.subviews[1].clipsToBounds = true
    }
    
    let commitGoalCountLabel1 = UILabel()
    let commitGoalCountLabel2 = UILabel()
    
    func makeCommitGoalLabel() {
        [commitGoalCountLabel1, commitGoalCountLabel2].forEach { label in
            label.textColor = .appColor(.labelColor)
            label.font = .notoFont(size: .Regular, ofSize: 12)
            view.addSubview(label)
        }
        commitGoalCountLabel1.text = "1개"
        
        //TODO: dummy 추후 변경 얘정
        commitLabel2.text = "15개"
    }
    
    
    func cellViewMake() {
        [profileView, commitView1, commitView2, commitGoalView, commitChartView]
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
        
        //TODO: dummy 추후 변경 예정
        
        profileImage.image = UIImage(named: "profiedaeheeKim")
        profilenName.text = "kimdaehee0824"
        profileDetail.text = "팔로워 67명 | 팔로우 29명"
        
        commitCountLabel1.text = "12개"
        commitCountLabel2.text = "23개"
        
        commitLabel1.text = "Today Commit"
        commitLabel2.text = "week commit"
        
        
        cellViewMake()
        makeDayCommitView()
        makeCommitGoalLabel()
        
        [profileImage, profilenName, profileDetail].forEach {
            profileView.addSubview($0)
        }
        [commitLabel1, commitCountLabel1].forEach {
            commitView1.addSubview($0)
        }
        [commitLabel2, commitCountLabel2].forEach {
            commitView2.addSubview($0)
        }
        [commitGoalProgressView, commitGoalLabel].forEach {
            commitGoalView.addSubview($0)
        }
        
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
        
        // commitCountView
        
        commitView1.snp.makeConstraints {
            $0.top.equalTo(profileView.snp.bottom).offset(10)
            $0.left.equalTo(contentView).inset(15)
            $0.right.equalTo(contentView.snp.centerX).offset(-7.5)
            $0.height.equalTo(135)
        }
        
        commitView2.snp.makeConstraints {
            $0.top.equalTo(profileView.snp.bottom).offset(10)
            $0.left.equalTo(contentView.snp.centerX).offset(7.5)
            $0.right.equalTo(contentView).inset(15)
            $0.height.equalTo(135)
        }
        
        [commitLabel1, commitLabel2].forEach { label in
            label.snp.makeConstraints {
                $0.left.equalTo(15)
                $0.top.equalTo(15)
                $0.height.equalTo(20)
            }
        }
        
        [commitCountLabel1, commitCountLabel2].forEach { label in
            label.snp.makeConstraints {
                $0.right.bottom.equalTo(-15)
                $0.height.equalTo(40)
            }
        }
    }
}
