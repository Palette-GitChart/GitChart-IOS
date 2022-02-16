//
//  MyAPI+Request.swift
//  GitChart
//
//  Created by 김대희 on 2022/02/17.
//

import Foundation
import RxSwift
import Moya
import Alamofire
import Then

enum MyAPIError: Error {
  case empty
  case requestTimeout(Error)
  case internetConnection(Error)
  case restError(Error, statusCode: Int? = nil, errorCode: String? = nil)
  
  var statusCode: Int? {
    switch self {
    case let .restError(_, statusCode, _):
      return statusCode
    default:
      return nil
    }
  }
  var errorCodes: [String] {
    switch self {
    case let .restError(_, _, errorCode):
      return [errorCode].compactMap { $0 }
    default:
      return []
    }
  }
  var isNoNetwork: Bool {
    switch self {
    case let .requestTimeout(error):
      fallthrough
    case let .restError(error, _, _):
      return API.isNotConnection(error: error) || API.isLostConnection(error: error)
    case .internetConnection:
      return true
    default:
      return false
    }
  }
}
