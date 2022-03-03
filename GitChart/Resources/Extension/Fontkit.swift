//
//  Fontkit.swift
//  GitChart
//
//  Created by 김대희 on 2022/02/10.
//

import Foundation
import UIKit


enum notoSans {
    case Regular
    case Bold
}

extension UIFont {
    static func roundedFont(ofSize fontSize: CGFloat, weight: UIFont.Weight) -> UIFont {
        let systemFont = UIFont.systemFont(ofSize: fontSize, weight: weight)
        let font: UIFont
        
        if #available(iOS 13.0, *) {
            if let descriptor = systemFont.fontDescriptor.withDesign(.rounded) {
                font = UIFont(descriptor: descriptor, size: fontSize)
            } else {
                font = systemFont
            }
        } else {
            font = systemFont
        }
        return font
    }
    
    static func notoFont(size : notoSans, ofSize : CGFloat) -> UIFont {
        switch size {
        case .Regular:
            return UIFont(name: "NotoSans", size: ofSize)!
        case .Bold:
            return UIFont(name: "NotoSans-Bold", size: ofSize)!
        }
    }
}
