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
}
