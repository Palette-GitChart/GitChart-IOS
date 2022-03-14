//
//  FriendsDetailVC.swift
//  GitChart
//
//  Created by 김대희 on 2022/03/14.
//

import UIKit

class FriendsDetailVC : BaseViewController {
    
    var githubURL = ""
    
    let friendProfile = UIImageView().then {
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 50
        $0.layer.borderWidth = 0.5
        $0.layer.borderColor = UIColor.secondaryLabel.cgColor
    }
    
    let friendTitlelabel = UILabel().then {
        $0.textColor = .appColor(.subColor)
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
    
    override func configureUI() {
        navigationItem.largeTitleDisplayMode = .never
        self.navigationController?.navigationBar.tintColor = .appColor(.mainColor)

    }
}
