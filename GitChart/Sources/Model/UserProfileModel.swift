//
//  UserProfileModel.swift
//  GitChart
//
//  Created by 김대희 on 2022/02/13.
//

import Foundation

struct UserProfile : Codable {
    let login : String
    let name : String?
    
    let followers : Int
    let following : Int
    
    let avatar_url : String?
    let email : String?
}
