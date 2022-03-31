//
//  AppStoreCheck.swift
//  GitChart
//
//  Created by 김대희 on 2022/03/31.
//

import Foundation

func isUpdateAvailable(completion: @escaping (Bool?, Error?) -> Void) throws -> URLSessionDataTask {
    guard let info = Bundle.main.infoDictionary,
        let currentVersion = info["CFBundleShortVersionString"] as? String,
        let identifier = info["CFBundleIdentifier"] as? String,
        let url = URL(string: "http://itunes.apple.com/lookup?bundleId=\(identifier)") else {
            throw VersionError.invalidBundleInfo
    }
    let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
        do {
            if let error = error { throw error }
            guard let data = data else { throw VersionError.invalidResponse }
            let json = try JSONSerialization.jsonObject(with: data, options: [.allowFragments]) as? [String: Any]
            guard let result = (json?["results"] as? [Any])?.first as? [String: Any], let version = result["version"] as? String else {
                throw VersionError.invalidResponse
            }
            print(version)
            
            completion(version != currentVersion, nil)
        } catch {
            completion(nil, error)
        }
    }
    task.resume()
    return task
}


enum VersionError: Error {
    case invalidResponse, invalidBundleInfo
}
