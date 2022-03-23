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
import SPIndicator


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

// MARK: Moya Wrapper

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
// MARK: Error Handling
extension API {
    private func handleInternetConnection<T: Any>(error: Error) throws -> Single<T> {
        guard
            let urlError = Self.converToURLError(error),
            Self.isNotConnection(error: error)
        else { throw error }
        throw MyAPIError.internetConnection(urlError)
    }
    
    private func handleTimeOut<T: Any>(error: Error) throws -> Single<T> {
        guard
            let urlError = Self.converToURLError(error),
            urlError.code == .timedOut
        else { throw error }
        throw MyAPIError.requestTimeout(urlError)
    }
    
    private func handleREST<T: Any>(error: Error) throws -> Single<T> {
        guard error is MyAPIError else {
            throw MyAPIError.restError(
                error,
                statusCode: (error as? MoyaError)?.response?.statusCode,
                errorCode: (try? (error as? MoyaError)?.response?.mapJSON() as? [String: Any])?["code"] as? String
            )
        }
        throw error
    }
}

// MARK: Moya Request
extension API {
    static let moya = MoyaWrapper.provider
    
    static var jsonDecoder: JSONDecoder {
        let decoder = JSONDecoder()
        return decoder
    }
    
    func request(
        file: StaticString = #file,
        function: StaticString = #function,
        line: UInt = #line
    ) -> Single<Response> {
        
        let endpoint = API.Wrapper(base: self)
        let requestString = "\(endpoint.method)\(endpoint.baseURL)\(endpoint.path)"
        
        return Self.moya.rx.request(endpoint)
            .filterSuccessfulStatusCodes()
            .catch(self.handleInternetConnection)
                .catch(self.handleTimeOut)
                .catch(self.handleREST)
                .do(
                    onSuccess: { response in
                        let requestContent = "🛰 SUCCESS: \(requestString) (\(response.statusCode))"
                        print(requestContent, file, function, line)
                    },
                    onError: { rawError in
                        switch rawError {
                        case MyAPIError.requestTimeout:
                            print("---TODO: alert MyAPIError.requestTimeout---")
                        case MyAPIError.internetConnection:
                            print("--TODO: alert MyAPIError.internetConnection---")
                        case let MyAPIError.restError(error, _, _):
                            guard let response = (error as? MoyaError)?.response else { break }
                            if let jsonObject = try? response.mapJSON(failsOnEmptyData: false) {
                                let errorDictionary = jsonObject as? [String: Any]
                                guard let key = errorDictionary?.first?.key else { return }
                                let message: String
                                if let description = errorDictionary?[key] as? String {
                                    message = "🛰 FAILURE: \(requestString) (\(response.statusCode)\n\(key): \(description)"
                                } else if let description = (errorDictionary?[key] as? [String]) {
                                    message = "🛰 FAILURE: \(requestString) (\(response.statusCode))\n\(key): \(description)"
                                } else if let rawString = String(data: response.data, encoding: .utf8) {
                                    message = "🛰 FAILURE: \(requestString) (\(response.statusCode))\n\(rawString)"
                                } else {
                                    message = "🛰 FAILURE: \(requestString) (\(response.statusCode)"
                                }
                                print(message)
                            }
                        default:
                            break
                        }
                    },
                    onSubscribe: {
                        let message = "REQUEST: \(requestString)"
                        print(message, file, function, line)
                    }
                )
    }
    
    func requestErrorAlert(
        file: StaticString = #file,
        function: StaticString = #function,
        line: UInt = #line
    ) -> Single<Response>  {
        
        let endpoint = API.Wrapper(base: self)
        
        return Self.moya.rx.request(endpoint)
            .filterSuccessfulStatusCodes()
            .catch(self.handleInternetConnection)
                .catch(self.handleTimeOut)
                .catch(self.handleREST)
                .do(
                    onError: { rawError in
                        switch rawError {
                        case MyAPIError.requestTimeout:
                            print("---TODO: alert MyAPIError.requestTimeout---")
                            SPIndicator.present(title: "오류 발생", message: "requestTimeout", preset: .error, from: .top)
                        case MyAPIError.internetConnection:
                            print("--TODO: alert MyAPIError.internetConnection---")
                            SPIndicator.present(title: "오류 발생", message: "인터넷에 연결되지 않음", preset: .error, from: .top)
                        case let MyAPIError.restError(error, _, _):
                            guard let response = (error as? MoyaError)?.response else { break }
                            if response.statusCode == 403 {
                                SPIndicator.present(title: "한도 초과!", message: "잠시 후 다시 실행해 주세요v", preset: .error, from: .top)
                            } else {
                                SPIndicator.present(title: "오류 발생", message: "\(response.statusCode) Error", preset: .error, from: .top)
                            }
                            
                        default:
                            break
                        }
                    }
                )
    }
}
