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
    
    case mainBackColor
    
}

extension UIColor {
    static func appColor(_ name : AssetsColor) -> UIColor {
        switch name {
        case .mainColor:
            return UIColor(named: "mainColor")!
        case .mainBackColor:
            return UIColor(named: "BackColor")!
        case .labelColor:
            return UIColor(named: "labelColor")!
        case .subColor:
            return UIColor(named: "subColor")!
        }
    }
}
