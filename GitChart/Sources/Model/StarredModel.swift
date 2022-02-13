//
//  StarredModel.swift
//  GitChart
//
//  Created by 김대희 on 2022/02/13.
//

import Foundation

struct Starred : Codable {
    let name : String
    let owner : Owner
    let description : String?
    let html_url : String
    let language : String?
    let forks_count : Int
    let watchers_count : Int
    
}

struct Owner : Codable {
    let login : String
    let avatar_url : String
}
