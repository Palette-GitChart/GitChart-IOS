//
//  BaseURL.swift
//  GitChart
//
//  Created by 김대희 on 2022/02/11.
//

import Foundation

let gitURL = "https://api.github.com/users"

let myURL = "http://3.38.95.103:5000"

extension API {
    func getBaseURL() -> URL {
        switch self {
            
        case .dayCommit(_), .weekCommit(_), .mounthCommit(_), .yearCommit(_):
            return URL(string: myURL)!
            
        case .weekArray(_), .mounthArray(_), .yearArray(_):
            return URL(string: myURL)!
            
        case .getUserProfile(_), .getUserStarred(_):
            return URL(string: gitURL)!
            
        }
    }
    
}
