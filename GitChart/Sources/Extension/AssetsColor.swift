//
//  AssetsColor.swift
//  GitChart
//
//  Created by 김대희 on 2022/02/06.
//

import Foundation
import UIKit

enum AssetsColor {
    
    // Main Color
    
    case mainColor
    case mainBackColor
    
}

extension UIColor {
    static func appColor(_ name : AssetsColor) -> UIColor {
        switch name {
        case .mainColor:
            return UIColor(named: "mainColor")!
        case .mainBackColor:
            return UIColor(named: "BackColor")!
        }
    }
}
