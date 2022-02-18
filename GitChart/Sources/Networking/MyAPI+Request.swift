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

extension API {
  struct Wrapper: TargetType {
    let base: API
    
    var baseURL: URL { self.base.baseURL }
    var path: String { self.base.path }
    var method: Moya.Method { self.base.method }
    var sampleData: Data { self.base.sampleData }
    var task: Task { self.base.task }
    var headers: [String : String]? { self.base.headers }
  }
  
  private enum MoyaWrapper {
    struct Plugins {
      var plugins: [PluginType]
      
      init(plugins: [PluginType] = []) {
        self.plugins = plugins
      }
      
      func callAsFunction() -> [PluginType] { self.plugins }
    }
    
    static var provider: MoyaProvider<API.Wrapper> {
      let plugins = Plugins(plugins: [])
      
      let configuration = URLSessionConfiguration.default
      configuration.timeoutIntervalForRequest = 30
      configuration.urlCredentialStorage = nil
      let session = Session(configuration: configuration)
      
      return MoyaProvider<API.Wrapper>(
        endpointClosure: { target in
          MoyaProvider.defaultEndpointMapping(for: target)
        },
        session: session,
        plugins: plugins()
      )
    }
  }
}
