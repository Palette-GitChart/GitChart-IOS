//
//  StarDetailVC.swift
//  GitChart
//
//  Created by 김대희 on 2022/03/10.
//

import Foundation
import UIKit

final class StarDetailVC : BaseViewController {
    
    var starred : Starred?
    
    let starProfile = UIImageView().then {
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 25
        $0.layer.borderWidth = 0.5
        $0.layer.borderColor = UIColor.secondaryLabel.cgColor
    }
    
    let starTitlelabel = UILabel().then {
        $0.textColor = .appColor(.subColor)
        $0.font = .roundedFont(ofSize: 25, weight: .semibold)
        $0.textAlignment = .center
    }
    
    let starDetailLabel = UILabel().then {
        $0.textColor = .appColor(.labelColor)
        $0.font = .roundedFont(ofSize: 18, weight: .regular)
    }
    
    let forkLabel = UILabel()
    let watchlabel = UILabel()
    
    override func configureUI() {
        
        [forkLabel, watchlabel].forEach {
            $0.font = .notoFont(size: .Regular, ofSize: 20)
            $0.textColor = .appColor(.labelColor)
        }
        
        [starProfile, starTitlelabel, starDetailLabel, watchlabel, forkLabel].forEach {
            view.addSubview($0)
        }
        
    }
    
    override func setupConstraints() {
        
    }
        
}
