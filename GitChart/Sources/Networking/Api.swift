//
//  Api.swift
//  GitChart
//
//  Created by 김대희 on 2022/02/12.
//

import Foundation
import Moya

enum API {
    
    // Commit
    
    case dayCommit(_ name: String)
    case weekCommit(_ name: String)
    case mounthCommit(_ name: String)
    case yearCommit(_ name: String)
    
    // Commit Array
    
    case weekArray(_ name: String)
    case mounthArray(_ name: String)
    case yearArray(_ name: String)
    
    // Github API User
    
    case getUserProfile(_ name: String)
    case getUserStarred(_ name: String)
    
}

extension API: Moya.TargetType {
  var baseURL: URL { self.getBaseURL() }
  var path: String { self.getPath() }
  var method: Method { self.getMethod() }
  var sampleData: Data { Data() }
  var task: Task {  self.getTask() }
  var headers: [String : String]? { ["Content-Type": "application/json"] }
}
