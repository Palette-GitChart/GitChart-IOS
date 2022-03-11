//
//  StarDetailVC.swift
//  GitChart
//
//  Created by 김대희 on 2022/03/10.
//

import Foundation
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
        
        $0.font = .roundedFont(ofSize: 18, weight: .regular)
    }
    
    let visitWebButton = UIButton().then {
        $0.setTitle("Web에서 보기", for: .normal)
        $0.backgroundColor = UIColor(rgb: 0x67C58E).withAlphaComponent(0.9)
        $0.titleLabel?.textColor = .white
        $0.titleLabel?.font = .notoFont(size: .Regular, ofSize: 22)
        $0.layer.cornerRadius = 10
    }
    
    let forkLabel = UILabel()
    let watchlabel = UILabel()
    
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
        
    }
    
    override func setupConstraints() {
        
    }
        
}
