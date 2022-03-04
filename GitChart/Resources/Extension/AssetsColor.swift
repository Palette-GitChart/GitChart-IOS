//
//  AssetsColor.swift
//  GitChart
//
//  Created by 김대희 on 2022/02/06.
//

import Foundation
import UIKit

enum AssetsColor {
    
    //Label Color
    
    case labelColor
    
    // Main Color
    
    case mainColor
    case subColor
    
    //Screen Color
    case backgroundColor
    case cellColor
    case tabarNunclickColor
    
}

extension UIColor {
    static func appColor(_ name : AssetsColor) -> UIColor {
        switch name {
        case .mainColor:
            return UIColor(named: "mainColor")!
        case .cellColor:
            return UIColor(named: "cellColor")!
        case .backgroundColor:
            return UIColor(named: "backgroundColor")!
        case .tabarNunclickColor:
            return UIColor(named: "tabarnunclickedColor")!
        case .labelColor:
            return UIColor(named: "labelColor")!
        case .subColor:
            return UIColor(named: "subColor")!
        }
    }
    
    convenience init(red: Int, green: Int, blue: Int, a: Int = 0xFF) {
        self.init(
            red: CGFloat(red) / 255.0,
            green: CGFloat(green) / 255.0,
            blue: CGFloat(blue) / 255.0,
            alpha: CGFloat(a) / 255.0
        )
    }

    convenience init(rgb: Int) {
           self.init(
               red: (rgb >> 16) & 0xFF,
               green: (rgb >> 8) & 0xFF,
               blue: rgb & 0xFF
           )
       }

    convenience init(argb: Int) {
        self.init(
            red: (argb >> 16) & 0xFF,
            green: (argb >> 8) & 0xFF,
            blue: argb & 0xFF,
            a: (argb >> 24) & 0xFF
        )
    }
    
}
