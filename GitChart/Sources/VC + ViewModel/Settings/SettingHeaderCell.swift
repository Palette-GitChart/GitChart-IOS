//
//  SettingHeaderCell.swift
//  GitChart
//
//  Created by 김대희 on 2022/03/21.
//

import UIKit
import RxSwift

class SettingHeaderCell: BaseTableViewCell {
    
    let disposeBag = DisposeBag()
    
    let mainView = UIView().then {
        $0.backgroundColor = .appColor(.cellColor)
        $0.layer.cornerRadius = 10
    }
    
    let userImage = UIImageView().then {
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 25
        $0.layer.borderWidth = 0.5
        $0.layer.borderColor = UIColor.secondaryLabel.cgColor
    }
    
    let nameLabel = UILabel().then {
        $0.font = .roundedFont(ofSize: 25, weight: .medium)
        $0.textColor = .appColor(.labelColor)
    }
    
    override func configureUI() {
        contentView.backgroundColor = .appColor(.backgroundColor)
        contentView.addSubview(mainView)
        nameLabel.text = "No Named"
        [userImage, nameLabel].forEach {
            mainView.addSubview($0)
        }
        bindProfile()
    }
    
    func bindProfile() {
        let username = UserDefaults.standard.string(forKey: "username") ?? ""
        API.getUserProfile(username).request().subscribe {event in
            switch event {
            case .success(let response):
                print(response.data)
                guard let data = try? JSONDecoder().decode(UserProfile.self, from: response.data) else {
                    return
                }
                
                self.nameLabel.text = data.login
                self.userImage.kf.indicatorType = .activity
                self.userImage.setImage(with: data.avatar_url ?? "")
                
            case .failure(let error):
                print("😔 error : \(error)")
            }
        }.disposed(by: disposeBag)
        
    }
    
    
    override func setupConstraints() {
        mainView.snp.makeConstraints {
            $0.height.equalTo(90)
            $0.top.bottom.equalTo(contentView).inset(5)
            $0.leading.trailing.equalTo(contentView).inset(15)
        }
        userImage.snp.makeConstraints {
            $0.width.height.equalTo(50)
            $0.centerY.equalTo(mainView)
            $0.left.equalTo(mainView).offset(15)
        }
        nameLabel.snp.makeConstraints {
            $0.centerY.equalTo(userImage)
            $0.left.equalTo(userImage.snp.right).offset(20)
            $0.height.equalTo(25)
        }
        
    }
}

class VersionCell : BaseTableViewCell {
    
    let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as! String
    
    func currentAppVersion() -> String {
        if let info: [String: Any] = Bundle.main.infoDictionary,
           let currentVersion: String = info["CFBundleShortVersionString"] as? String {
            return currentVersion
        }
        return "nil"
    }
    let versionLabel = UILabel().then {
        $0.text = "Ver 1.0.2"
        $0.font = .roundedFont(ofSize: 17, weight: .medium)
        $0.textColor = .separator
        $0.textAlignment = .center
    }
    
    override func configureUI() {
        contentView.backgroundColor = .appColor(.backgroundColor)
        contentView.addSubview(versionLabel)
    }
    override func setupConstraints() {
        versionLabel.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.height.equalTo(30)
        }
    }
    
}
