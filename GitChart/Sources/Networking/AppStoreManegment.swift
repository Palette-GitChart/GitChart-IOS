//
//  AppStoreManegment.swift
//  GitChart
//
//  Created by 김대희 on 2022/03/31.
//

import Foundation
import UIKit

func isUpdateAvailable() -> Bool {
        guard let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String,
              let identifier = Bundle.main.infoDictionary?["CFBundleIdentifier"] as? String,
            let url = URL(string: "http://itunes.apple.com/lookup?bundleId=\(identifier)"),
            let data = try? Data(contentsOf: url),
            let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any],
              let results = json["results"] as? [[String: Any]],
            results.count > 0,
            let appStoreVersion = results[0]["version"] as? String
            else { return false }
        if !(version == appStoreVersion) { return true }
        else{ return false }
    }

func openAppStore() {
    let url = "itms-apps://itunes.apple.com/app/1616160064"
    if let url = URL(string: url), UIApplication.shared.canOpenURL(url) {
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(url)
        }
    }
}
