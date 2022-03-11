//
//  StarDetailVC.swift
//  GitChart
//
//  Created by 김대희 on 2022/03/10.
//

import SafariServices
import UIKit

final class StarDetailVC : BaseViewController {
    
    var githubURL = ""
    
    let starProfile = UIImageView().then {
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 50
        $0.layer.borderWidth = 0.5
        $0.layer.borderColor = UIColor.secondaryLabel.cgColor
    }
    
    let starTitlelabel = UILabel().then {
        $0.textColor = .appColor(.subColor)
        $0.font = .roundedFont(ofSize: 25, weight: .semibold)
        $0.textAlignment = .center
    }
    
    let starDetailLabel = UITextView().then {
        $0.textColor = .appColor(.labelColor)
        $0.textAlignment = .center
        $0.backgroundColor = .clear
        $0.isEditable = false
        $0.isSelectable = false
        $0.font = .roundedFont(ofSize: 18, weight: .regular)
    }
    
    let visitWebButton = UIButton().then {
        $0.setTitle("Web에서 보기", for: .normal)
        $0.backgroundColor = UIColor(rgb: 0x67C58E).withAlphaComponent(0.9)
        $0.titleLabel?.textColor = .white
        $0.titleLabel?.font = .notoFont(size: .Regular, ofSize: 22)
        $0.layer.cornerRadius = 15
    }
    
    let forkLabel = UILabel().then {
        $0.textAlignment = .right
    }
    let watchlabel = UILabel().then {
        $0.textAlignment = .left
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
        self.tabBarController?.tabBar.isTranslucent = true // <- 이코드가 꼭 있어야함
        
    }
    
    
    override func configureUI() {
        navigationItem.largeTitleDisplayMode = .never
        
        self.navigationController?.navigationBar.tintColor = .appColor(.mainColor)
        
        [forkLabel, watchlabel].forEach {
            $0.font = .notoFont(size: .Regular, ofSize: 20)
            $0.textColor = .appColor(.labelColor)
        }
        
        [starProfile, starTitlelabel, starDetailLabel, watchlabel, forkLabel, visitWebButton].forEach {
            view.addSubview($0)
        }
        adjustUITextViewHeight(arg: starDetailLabel)
        
        visitWebButton.rx.tap.bind {
            let safariViewController = SFSafariViewController(url: URL(string: self.githubURL)!)
            safariViewController.modalPresentationStyle = .overFullScreen
            self.present(safariViewController, animated: true, completion: nil)
        }.disposed(by: disposeBag)
        
    }
    
    override func setupConstraints() {
        starProfile.snp.makeConstraints {
            $0.width.height.equalTo(100)
            $0.centerX.equalTo(view)
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
        }
        starTitlelabel.snp.makeConstraints {
            $0.height.equalTo(40)
            $0.centerX.equalTo(view)
            $0.top.equalTo(starProfile.snp.bottom).offset(10)
        }
        starDetailLabel.snp.makeConstraints {
            $0.centerX.equalTo(view)
            $0.left.right.equalTo(view).inset(15)
            $0.top.equalTo(starTitlelabel.snp.bottom).offset(10)
        }
        
        forkLabel.snp.makeConstraints {
            $0.height.equalTo(30)
            $0.top.equalTo(starDetailLabel.snp.bottom).offset(10)
            $0.right.equalTo(view.snp.centerX).offset(-10)
            $0.left.equalTo(10)
        }
        watchlabel.snp.makeConstraints {
            $0.height.equalTo(30)
            $0.top.equalTo(starDetailLabel.snp.bottom).offset(10)
            $0.left.equalTo(view.snp.centerX).offset(10)
            $0.right.equalTo(-10)
        }
        
        visitWebButton.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(5)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(10)
            $0.height.equalTo(50)
        }
    }
    
    func adjustUITextViewHeight(arg : UITextView) {
        arg.translatesAutoresizingMaskIntoConstraints = true
        arg.sizeToFit()
        arg.isScrollEnabled = false
    }
    
    
}
