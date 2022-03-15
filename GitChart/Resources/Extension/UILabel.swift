//
//  UILabel.swift
//  GitChart
//
//  Created by 김대희 on 2022/03/15.
//

import Foundation
import UIKit

extension UILabel {
    func makeCommitCountLabel(_ color : UIColor) {
        
        let str = self.text ?? ""
        let attributedStr = NSMutableAttributedString(string: self.text ?? "")
        let range = (str as NSString).range(of: "개")
        
        attributedStr.addAttribute(.font, value: UIFont.notoFont(size: .Regular, ofSize: 25), range: range)
        attributedStr.addAttribute(.foregroundColor, value: UIColor.appColor(.labelColor), range: range)
        
        self.font = .roundedFont(ofSize: 50, weight: .medium)
        self.attributedText = attributedStr

    }
}
