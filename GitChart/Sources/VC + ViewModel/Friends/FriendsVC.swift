//
//  FriendsVC.swift
//  GitChart
//
//  Created by 김대희 on 2022/02/09.
//

import UIKit

class FriendsVC : BaseViewController {
    
    override func viewDidAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.appColor(.labelColor), .font : FontKit.roundedFont(ofSize: 20, weight: .semibold)]
        self.navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor: UIColor.appColor(.labelColor), .font : FontKit.roundedFont(ofSize: 34, weight: .bold)]
    }

    
    override func configureUI() {
        self.title = "Friends"
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
}
