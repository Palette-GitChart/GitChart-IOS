//
//  BaseURL.swift
//  GitChart
//
//  Created by 김대희 on 2022/02/11.
//

import Foundation
import Moya

let gitURL = "https://api.github.com/"

let myURL = "https://githubwebcrawler.herokuapp.com"

extension API {
    func getBaseURL() -> URL {
        switch self {
            
        case .allCommit(_), .dayCommit(_), .weekCommit(_), .mounthCommit(_), .yearCommit(_):
            return URL(string: myURL)!
            
        case .weekArray(_), .monthArray(_), .yearArray(_):
            return URL(string: myURL)!
            
        case .getUserProfile(_), .getUserStarred(_), .getUserFollowing(_):
            return URL(string: gitURL)!
            
        }
    }
    func getPath() -> String {
        switch self {
        case .allCommit(let username):
            return "/\(username)"
        case .dayCommit(let username):
            return "/\(username)/daycount"
        case .weekCommit(let username):
            return "/\(username)/weekcount"
        case .mounthCommit(let username):
            return "/\(username)/monthcount"
        case .yearCommit(let username):
            return "/\(username)/yearcount"
        case .weekArray(let username):
            return "/\(username)/weekarray"
        case .monthArray(let username):
            return "/\(username)/montharray"
        case .yearArray(let username):
            return "/\(username)/yeararray"
        case .getUserProfile(let username):
            return "users/\(username)"
        case .getUserStarred(let username):
            return "users/\(username)/starred"
        case .getUserFollowing(let username):
            return "users/\(username)/starred"
        }
    }
    func getMethod() -> Moya.Method {
        switch self {
        default: return .get
        }
    }
}
