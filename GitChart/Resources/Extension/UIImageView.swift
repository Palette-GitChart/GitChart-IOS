//
//  UIImageView.swift
//  GitChart
//
//  Created by 김대희 on 2022/03/08.
//

import Foundation
import Kingfisher

extension UIImageView {
  func setImage(with urlString: String) {
    ImageCache.default.retrieveImage(forKey: urlString, options: nil) { result in
      switch result {
      case .success(let value):
        if let image = value.image {
          //캐시가 존재하는 경우
          self.image = image
        } else {
          guard let url = URL(string: urlString) else { return }
          let resource = ImageResource(downloadURL: url, cacheKey: urlString)
          self.kf.setImage(with: resource)
        }
      case .failure(let error):
        print("🌨 Image Error : \(error)")
      }
    }
  }
}
