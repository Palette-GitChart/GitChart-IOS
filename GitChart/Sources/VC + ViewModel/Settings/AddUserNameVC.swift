//
//  AddUserNameVC.swift
//  GitChart
//
//  Created by 김대희 on 2022/03/22.
//

import UIKit

final class AddUserNameVC : BaseViewController {
    
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
    
    private let saveButton = UIButton().then {
        $0.setTitle("완료", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.titleLabel?.font = .notoFont(size: .Regular, ofSize: 22)
        $0.backgroundColor = .appColor(.mainColor)
        $0.layer.cornerRadius = 20
    }
    
    override func configureUI() {
        [titleLabel, usernameTextField, saveButton, textFieldBottomLine].forEach {
            view.addSubview($0)
        }
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
    
}