//
//  UnderlineTextField.swift
//  pokemon-finder
//
//  Created by Samuel Henrique on 5/21/21.
//

import UIKit

extension UIImageView {
  func load(from url: URL, contentMode mode: ContentMode = .scaleAspectFit) {
    contentMode = mode
    URLSession.shared.dataTask(with: url) { data, response, error in
      guard
        let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
        let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
        let data = data, error == nil,
        let image = UIImage(data: data)
      else { return }
      DispatchQueue.main.async() { [weak self] in
        self?.image = image
      }
    }.resume()
  }
  func load(from link: String, contentMode mode: ContentMode = .scaleAspectFit) {
    guard let url = URL(string: link) else { return }
    load(from: url, contentMode: mode)
  }
}
