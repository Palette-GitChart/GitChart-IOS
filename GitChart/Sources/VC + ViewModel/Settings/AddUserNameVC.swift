//
//  AddUserNameVC.swift
//  GitChart
//
//  Created by 김대희 on 2022/03/22.
//

import UIKit
import RxRelay

final class AddUserNameVC : BaseViewController {
    
    let isSaveSubject = BehaviorRelay<Bool>(value: false)
    
    private let titleLabel = UILabel().then {
        
        $0.textColor = .appColor(.mainColor)
        $0.text = "Github 아이디를 입력하세요"
        $0.textAlignment = .center
        $0.font = .notoFont(size: .Bold, ofSize: 20)
    }
    
    private let usernameTextField = UITextField().then {
        $0.borderStyle = .none
        $0.placeholder = "Github 아이디"
        $0.tintColor = .appColor(.mainColor)
    }
    
    let textFieldBottomLine = UIView().then { $0.backgroundColor = .separator }
    let statusLabel = UILabel().then {
        $0.textColor = .red
        
    }
    
    private let saveButton = UIButton().then {
        $0.setTitle("완료", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.titleLabel?.font = .notoFont(size: .Regular, ofSize: 22)
        $0.layer.cornerRadius = 15
    }
    
    override func configureUI() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        [titleLabel, usernameTextField, saveButton, textFieldBottomLine].forEach {
            view.addSubview($0)
        }
        
        usernameTextField.rx.text.orEmpty.bind {
            if $0 == "" {
                UIView.animate(withDuration: 0.2) {
                    self.saveButton.backgroundColor = .separator
                }
            } else {
                UIView.animate(withDuration: 0.2) {
                    self.saveButton.backgroundColor = .appColor(.mainColor)
                    self.isSaveSubject.accept(true)
                }
            }
        }.disposed(by: disposeBag)
        
        saveButton.rx.tap.bind {
            self.isSaveSubject.bind { bool in
                if bool == true {
                    UserDefaults.standard.set(self.usernameTextField.text, forKey: "username")
                    self.dismiss(animated: true)
                }
            }.disposed(by: self.disposeBag)
        }.disposed(by: disposeBag)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    override func setupConstraints() {
        titleLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(10)
            $0.top.equalTo(40)
        }
        
        usernameTextField.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(40)
            $0.top.equalTo(titleLabel.snp.bottom).offset(70)
        }
        
        textFieldBottomLine.snp.makeConstraints {
            $0.top.equalTo(usernameTextField.snp.bottom).offset(5)
            $0.height.equalTo(1)
            $0.leading.trailing.equalToSuperview().inset(40)
        }
        
        saveButton.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(5)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(10)
            $0.height.equalTo(50)
        }
    }
    
    //MARK: - keyboardShow
    
    @objc func keyboardWillShow(noti: Notification) {
        let notinfo = noti.userInfo!
        let keyboardFrame = notinfo[UIResponder.keyboardFrameEndUserInfoKey] as! CGRect
        let heiget = keyboardFrame.size.height - self.view.safeAreaInsets.bottom
        let animateDuration = notinfo[UIResponder.keyboardAnimationDurationUserInfoKey] as! TimeInterval
        UIView.animate(withDuration: animateDuration) {
            self.saveButton.layer.cornerRadius = 0
            self.saveButton.snp.remakeConstraints {
                $0.height.equalTo(50)
                $0.leading.trailing.equalTo(self.view.safeAreaLayoutGuide)
                $0.bottom.equalTo(self.view.safeAreaLayoutGuide).inset(heiget)
            }
            self.view.layoutIfNeeded()
        }
    }
    @objc func keyboardWillHide(noti: Notification) {
        let notinfo = noti.userInfo!
        let animateDuration = notinfo[UIResponder.keyboardAnimationDurationUserInfoKey] as! TimeInterval
        UIView.animate(withDuration: animateDuration) {
            self.saveButton.layer.cornerRadius = 15
            self.saveButton.snp.remakeConstraints {
                $0.leading.trailing.equalTo(self.view.safeAreaLayoutGuide).inset(10)
                $0.height.equalTo(50)
                $0.bottom.equalTo(self.view.safeAreaLayoutGuide).inset(5)
            }
            self.view.layoutIfNeeded()
        }
    }
}
