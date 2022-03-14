//
//  HomeVC.swift
//  GitChart
//
//  Created by 김대희 on 2022/02/07.
//

import UIKit
import RxGesture
import RxSwift
import Kingfisher
import Charts

class HomeVC : BaseViewController {
    
    let viewModel = HomeViewModel()
    let refreshControl = UIRefreshControl()
    
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
    }
    
    let commitGoalCountLabel1 = UILabel()
    let commitGoalCountLabel2 = UILabel()
    
    func makeCommitGoalLabel() {
        [commitGoalCountLabel1, commitGoalCountLabel2].forEach { label in
            label.textColor = .appColor(.labelColor)
            label.font = .notoFont(size: .Regular, ofSize: 12)
            view.addSubview(label)
        }
        commitGoalCountLabel1.text = "0개"
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.appColor(.mainColor), .font : UIFont.roundedFont(ofSize: 20, weight: .semibold)]
        self.navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor: UIColor.appColor(.mainColor), .font : UIFont.roundedFont(ofSize: 34, weight: .bold)]
        self.title = "Home"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        self.navigationController?.navigationBar.sizeToFit()
    }
    
    
    //MARK: - configure
    
    override func configureUI() {
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        refreshControl.tintColor = .appColor(.labelColor)
        refreshControl.endRefreshing() // 초기화 - refresh 종료
        scrollView.refreshControl = refreshControl
        //TODO: dummy 추후 변경 예정
        
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
        
        bindViewModel()
        
        refreshControl.rx.controlEvent(.valueChanged).bind {
            self.bindViewModel()
            DispatchQueue.main.asyncAfter(wallDeadline: .now() + 3) {
                self.refreshControl.endRefreshing()
            }
            
        }.disposed(by: disposeBag)
    }
    
    func bindViewModel() {
        let output = viewModel.trans(
            .init(
                didCommitTap: commitView1.rx
                    .tapGesture().asDriver())
        )
        
        output.usernameStatus.bind { bool in
            
            if bool == false {
                let alert = UIAlertController(
                    title: "데이터를 받아올수 없습니다",
                    message: "인터넷 연결을 확인하시고, 처음 앱을 실행하셨다면 Github 아이디를 입력해 주새요!",
                    preferredStyle: UIAlertController.Style.alert)
                let okAction = UIAlertAction(title: "확인", style: .default) { action in
                }
                alert.addAction(okAction)
                self.present(alert, animated: false, completion: nil)
            }
            
        }.disposed(by: disposeBag)
        
        output.getUserProfile.bind() { user in
            self.profilenName.text = user.login
            self.profileDetail.text = "팔로워 \(user.followers)명 | 팔로우 \(user.following)명"
            self.profileImage.kf.indicatorType = .activity
            self.profileImage.setImage(with: user.avatar_url ?? "")
        }.disposed(by: disposeBag)
        
        output.getUserDayCommit
            .bind { count in
                self.commitCountLabel1.text = "\(count)개"
                self.commitGoalProgressView.setProgress(Float(Double(100/15*Int(count)!)/100), animated: true)
                self.commitCountLabel1.textColor = UIColor(rgb: 0x6EC7CD)
                self.makeDayCommitView()
            }.disposed(by: disposeBag)
        
        output.getWeekCommit
            .bind{ count in
                self.commitCountLabel2.text = "\(count)개"
                self.commitCountLabel2.textColor = .appColor(.subColor)
                self.makeDayCommitView()
            }.disposed(by: disposeBag)
        
        output.getMounthArray
            .bind{ user in
                for i in 0..<user.count {
                    let dataEntry = ChartDataEntry(x: Double(i), y: Double(user[i]))
                    self.lineChartEntry.append(dataEntry)
                }
                let linechart1 = LineChartDataSet(entries: self.lineChartEntry, label: "")
                let gradient = self.getGradientFilling(with: 0x7FC567, alpa: 0.84)
                linechart1.fill = Fill.fillWithLinearGradient(gradient, angle: 90.0)
                let data = LineChartData()
                self.setChartLine(line: linechart1, color: NSUIColor.appColor(.mainColor))
                data.addDataSet(linechart1)
                self.trandChart.data = data
                self.trandChart.animate(xAxisDuration: 0.5)
            }.disposed(by: disposeBag)
    }
    
    override func setupConstraints() {
        setupConstraint()
    }
    
}
