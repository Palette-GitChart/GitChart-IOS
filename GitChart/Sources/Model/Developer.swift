//
//  Developer.swift
//  GitChart
//
//  Created by 김대희 on 2022/03/24.
//

import Foundation

struct Developer {
    let mame : [String]
    let description : [String]
    let image : [String]
    let portfolio : [String]
    init () {
        self.mame = ["Daehee Kim", "Yongjin Lee", "Seokyeon Jang", "Sangwoon Lee"]
        self.image =  ["profiedaeheeKim", "profieYongjinLee", "profileseokyounJang", "profilesangwoonLee"]
        self.description = ["IOS Developer & Design", "Android Developer", "Design", "Backend Developer"]
        self.portfolio = ["github", "github", "behance", "github"]
    }
}
