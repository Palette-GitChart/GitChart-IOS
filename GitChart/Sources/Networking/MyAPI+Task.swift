//
//  MyAPI+Task.swift
//  GitChart
//
//  Created by 김대희 on 2022/02/16.
//

import Foundation
import Moya

extension API {
    func getTask() -> Task {
        switch self {
        default:
            return .requestParameters(parameters: request.toDictionary(), encoding: URLEncoding.queryString)
        }
    }
}

