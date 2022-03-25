//
//  EasterEggVC.swift
//  GitChart
//
//  Created by 김대희 on 2022/03/24.
//

import UIKit

class EasterEggVC : BaseViewController {
    
    let titleLabel = UILabel().then {
        $0.text = "GitChart를 이용해 주셔서 감사합니다."
        $0.font = .notoFont(size: .Bold, ofSize: 20)
        $0.textAlignment = .center
        $0.textColor = .appColor(.mainColor)
    }
    
    let subLabel = UILabel().then {
        $0.text = "마음이 따뜻해지는 숫자네요, 이스터 에그를 찾아줘서 고마워요"
        $0.font = .notoFont(size: .Regular, ofSize: 13)
        $0.textAlignment = .center
        $0.textColor = .appColor(.labelColor)
    }
    
    let imageView = UIImageView().then {
        $0.image = UIImage(named: "easterEgg")
        $0.backgroundColor = .white
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 15
        $0.layer.borderWidth = 2
        $0.layer.borderColor = UIColor.appColor(.mainColor).cgColor
        $0.contentMode = .scaleAspectFit
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.dismiss(animated: true)
    }

    override func configureUI() {
        [titleLabel, subLabel, imageView].forEach {
            view.addSubview($0)
        }
    }
    override func setupConstraints() {
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(25)
            $0.leading.trailing.equalTo(view).inset(20)
            $0.height.equalTo(20)
        }
        subLabel.snp.makeConstraints {
            $0.top.equalTo(60)
            $0.leading.trailing.equalTo(view).inset(20)
            $0.height.equalTo(20)

        }
        imageView.snp.makeConstraints {
            $0.leading.trailing.equalTo(view).inset(40)
            $0.top.bottom.equalTo(view).inset(160)
        }
    }
}
