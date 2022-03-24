//
//  SettingVC.swift
//  GitChart
//
//  Created by 김대희 on 2022/02/09.
//

import UIKit
import RxSwift
import SafariServices
import MessageUI

class SettingVC : BaseViewController {
    
    let settingTitleArray = ["Github 아이디 추가, 변경", "일일 커밋 목표 수정하기", "개발자 소개", "오픈소스", "문의하기"]
    
    let mainTableView = UITableView().then {
        $0.register(SettingListCell.self, forCellReuseIdentifier: "settingListCell")
        $0.backgroundColor = .clear
        $0.separatorStyle = .none
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.appColor(.labelColor), .font : UIFont.roundedFont(ofSize: 20, weight: .semibold)]
        mainTableView.reloadData()
    }
    
    override func configureUI() {
        self.title = "Setting"
        view.addSubview(mainTableView)
        mainTableView.delegate = self
        mainTableView.dataSource = self
    }
    
    override func setupConstraints() {
        mainTableView.snp.makeConstraints { $0.edges.equalToSuperview() }
    }
}

extension SettingVC : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = indexPath.row
        switch row {
        case 0:
            return SettingHeaderCell()
        case 1, 2, 3, 4, 5:
            let cell = tableView.dequeueReusableCell(withIdentifier: "settingListCell") as! SettingListCell
            cell.textLabbel.text = settingTitleArray[row-1]
            return cell
        case 6:
            return VersionCell()
        default:
            return UITableViewCell()
        }
    }
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        if indexPath.row == 1 {
            self.present(AddUserNameVC(), animated: true)
        }
        if indexPath.row == 2 {
            let alert = UIAlertController(title: "커밋 목표 수정", message: "자신이 목표로 하는 숫자를 입력해 주세요", preferredStyle: .alert)
            let ok = UIAlertAction(title: "OK", style: .default) { (ok) in
                if alert.textFields?[0].text == "1004" {
                    self.present(EasterEggVC(), animated: true)
                }
                UserDefaults.standard.set(alert.textFields?[0].text, forKey: "commitCount")
            }
            let cancel = UIAlertAction(title: "cancel", style: .destructive)
            
            alert.addTextField { (textField) in
                textField.placeholder = "숫자를 입력해 주세요"
                textField.keyboardType = .numberPad
            }
            alert.addAction(cancel)
            alert.addAction(ok)
            alert.view.tintColor = .appColor(.mainColor)
            
            self.present(alert, animated: true, completion: nil)
        }
        
        if indexPath.row == 3 {
            let vc = DeveloperVC()
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        if indexPath.row == 4 {
            let safariViewController = SFSafariViewController(url: URL(string: "https://github.com/Palette-GitChart/GitChart-IOS/blob/main/LICENSE")!)
            safariViewController.preferredControlTintColor = .appColor(.mainColor)
            self.present(safariViewController, animated: true, completion: nil)
            
        }
        
        if indexPath.row == 5 {
            if MFMailComposeViewController.canSendMail() {
                let compseVC = MFMailComposeViewController()
                compseVC.mailComposeDelegate = self
                compseVC.setToRecipients(["kj0824@icloud.com"])
                compseVC.setSubject("GitChart 문의")
                compseVC.setMessageBody("에러 제보 시 IOS 버전과 iPhone 기종 등을 입력해 주세요", isHTML: false)
                self.present(compseVC, animated: true, completion: nil)
            }
            else {
                let safariViewController = SFSafariViewController(url: URL(string: "https://github.com/kimdaehee0824")!)
                safariViewController.preferredControlTintColor = .appColor(.mainColor)
                self.present(safariViewController, animated: true, completion: nil)
            }
        }
        return indexPath
    }
}

extension SettingVC : MFMailComposeViewControllerDelegate {
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
}
