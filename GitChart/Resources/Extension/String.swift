//
//  String.swift
//  GitChart
//
//  Created by 김대희 on 2022/03/02.
//

import Foundation

extension String {
    
    func localized(comment: String = "") -> String {
        return NSLocalizedString(self, comment: comment)
    }
    
}
 
