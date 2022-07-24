//
//  DeveloperVC.swift
//  GitChart
//
//  Created by 김대희 on 2022/03/23.
//

import UIKit
import SafariServices

class DeveloperVC : BaseViewController {
    
    let developer = Developer()
    
    let mainTableView = UITableView().then {
        $0.register(DeveloperCell.self, forCellReuseIdentifier: "developerCell")
        $0.backgroundColor = .clear
        $0.separatorStyle = .none
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
        self.tabBarController?.tabBar.isTranslucent = true // <- 이코드가 꼭 있어야함
    }
    
    override func configureUI() {
        navigationItem.largeTitleDisplayMode = .never
        self.navigationItem.title = "개발자 정보"
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.appColor(.labelColor)]
        self.navigationController?.navigationBar.sizeToFit()
        self.navigationController?.navigationBar.tintColor = .appColor(.mainColor)
        view.addSubview(mainTableView)
        
        mainTableView.delegate = self
        mainTableView.dataSource = self
        
    }
    
    override func setupConstraints() {
        mainTableView.snp.makeConstraints { $0.edges.equalToSuperview() }
    }
}


extension DeveloperVC : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return developer.mame.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "developerCell") as! DeveloperCell
        cell.nameLabel.text = developer.mame[indexPath.row]
        cell.descriptionlabel.text = developer.description[indexPath.row]
        cell.userImage.image = UIImage(named: developer.image[indexPath.row])
        cell.portfolioImage.image = UIImage(named: developer.portfolio[indexPath.row])?.withRenderingMode(.alwaysTemplate)
        cell.portfolioImage.tintColor = .label.withAlphaComponent(0.9)
        return cell
    }
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        let safariViewController = SFSafariViewController(url: URL(string: developer.url[indexPath.row])!)
        safariViewController.preferredControlTintColor = .appColor(.mainColor)
        safariViewController.modalPresentationStyle = .overFullScreen
        self.present(safariViewController, animated: true, completion: nil)
        return indexPath
    }
}
