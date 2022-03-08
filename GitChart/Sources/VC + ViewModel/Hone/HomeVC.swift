//
//  HomeVC.swift
//  GitChart
//
//  Created by 김대희 on 2022/02/07.
//

import UIKit
import RxGesture
import Kingfisher
import Charts

class HomeVC : BaseViewController {
    
    let viewModel = HomeViewModel()
    
    let scrollView = UIScrollView().then {
        $0.backgroundColor = .clear
    }
    
    let contentView = UIView().then {
        $0.backgroundColor = .clear
    }
    
    //MARK: Cell View
    
    let profileView = UIView()
    let commitView1 = UIView()
    let commitView2 = UIView()
    let commitGoalView = UIView()
    let commitTrandView = UIView()
    
    //MARK: Cell in UI
    
    // profileView
    
    let profileImage = UIImageView().then {
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 40
        $0.layer.borderWidth = 0.5
        $0.layer.borderColor = UIColor.secondaryLabel.cgColor
    }
    
    var profilenName = UILabel().then {
        $0.font = .roundedFont(ofSize: 25, weight: .medium)
        $0.textColor = .appColor(.labelColor)
    }
    
    let profileDetail = UILabel().then {
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
        $0.text = "Daily Commit Goal"
    }
    
    let commitGoalProgressView = UIProgressView().then {
        $0.progressTintColor = UIColor(rgb: 0x7FC567)
        $0.trackTintColor = UIColor(named: "progressTrackColor")
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 7.5
        $0.layer.sublayers![1].cornerRadius = 7.5// 뒤에 있는 회색 track
        $0.subviews[1].clipsToBounds = true
        $0.setProgress(1.0, animated: true)
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
        commitGoalCountLabel2.textAlignment = .right
        
        //TODO: dummy 추후 변경 얘정
        commitGoalCountLabel2.text = "15개"
    }
    
    //MARK: commitTrandView
    
    let commitTrandLabel = UILabel().then {
        $0.textColor = .appColor(.labelColor)
        $0.font = .roundedFont(ofSize: 20, weight: .semibold)
        $0.text = "Commit Trand"
    }
    
    let commitTrandCountLabel1 = UILabel()
    let commitTrandCountLabel2 = UILabel()
    
    func makeCommitTrandLabel() {
        [commitTrandCountLabel1, commitTrandCountLabel2].forEach { label in
            label.textColor = .appColor(.labelColor)
            label.font = .notoFont(size: .Regular, ofSize: 12)
            commitTrandView.addSubview(label)
        }
        commitTrandCountLabel2.textAlignment = .right
        commitTrandCountLabel2.text = "2022-03-10"
        commitTrandCountLabel1.text = "2021-03-10"
    }
    
    var lineChartEntry = [ChartDataEntry]()
    
    let trandChart = LineChartView()
    func cellViewMake() {
        [profileView, commitView1, commitView2, commitGoalView, commitTrandView]
            .forEach { v in
                v.backgroundColor = UIColor.appColor(.cellColor)
                v.layer.cornerRadius = 20
                contentView.addSubview(v)
            }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.appColor(.mainColor), .font : UIFont.roundedFont(ofSize: 20, weight: .semibold)]
        self.navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor: UIColor.appColor(.mainColor), .font : UIFont.roundedFont(ofSize: 34, weight: .bold)]
        self.title = "Home"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
    }
    
    override func viewWillAppear(_ animated: Bool) {
        DispatchQueue.main.async {
            self.navigationController?.navigationBar.sizeToFit()
        }
    }
    
    //MARK: - configure
    
    override func configureUI() {
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        //TODO: dummy 추후 변경 예정
        
        commitCountLabel1.text = "12개"
        commitCountLabel2.text = "23개"
        
        commitLabel1.text = "Today Commit"
        commitLabel2.text = "week commit"
        
        cellViewMake()
        makeDayCommitView()
        makeCommitGoalLabel()
        makeCommitTrandLabel()
        makeTrandChart()
        
        
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
        
        [commitTrandLabel, trandChart].forEach {
            commitTrandView.addSubview($0)
        }
        
        bind()
    }
    
    func bind() {
        let output = viewModel.trans(
            .init(
            didCommitTap: commitView1.rx
                .tapGesture().asDriver())
        )
        
        output.getUserProfile.bind() { user in
            self.profilenName.text = user.login
            self.profileDetail.text = "팔로워 \(user.followers)명 | 팔로우 \(user.following)명"
            self.profileImage.kf.indicatorType = .activity
            self.profileImage.setImage(with: user.avatar_url ?? "")
        }.disposed(by: disposeBag)
        
        output.getYearArray.bind{ user in
            for i in 0..<user.count {
                let dataEntry = ChartDataEntry(x: Double(i), y: Double(user[i]))
                self.lineChartEntry.append(dataEntry)
            }
            
            let linechart1 = LineChartDataSet(entries: self.lineChartEntry, label: "")
            let gradient = self.getGradientFilling()
            linechart1.fill = Fill.fillWithLinearGradient(gradient, angle: 90.0)
            linechart1.drawFilledEnabled = true
            linechart1.drawCirclesEnabled = false
            linechart1.drawValuesEnabled = false
            linechart1.highlightEnabled = false
            linechart1.mode = .cubicBezier
            linechart1.colors = [NSUIColor.appColor(.mainColor)]
            linechart1.cubicIntensity = 0.2
            linechart1.lineWidth = 2.0
            
            let data = LineChartData()
            data.addDataSet(linechart1)
            self.trandChart.data = data
        }.disposed(by: disposeBag)
        
    }
    
    override func setupConstraints() {
        setupConstraint()
    }
}
