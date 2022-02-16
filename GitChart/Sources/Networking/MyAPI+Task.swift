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

extension Encodable {
  func toDictionary() -> [String: Any] {
    do {
      let jsonEncoder = JSONEncoder()
      let encodedData = try jsonEncoder.encode(self)
      
      let dictionaryData = try JSONSerialization.jsonObject(
        with: encodedData,
        options: .allowFragments
      ) as? [String: Any]
      return dictionaryData ?? [:]
    } catch {
      return [:]
    }
  }
}
