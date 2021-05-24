//
//  URLRequestExtension.swift
//  pokemon-finder
//
//  Created by Samuel Henrique on 5/21/21.
//

import Foundation

extension URLRequest {
  init(baseUrl: String, path: String, method: RequestMethod, params: [String: Any]) {
    let url = URL(baseUrl: baseUrl, path: path, params: params, method: method)
    self.init(url: url)
    httpMethod = method.rawValue
    setValue("application/json", forHTTPHeaderField: "Accept")
    setValue("application/json", forHTTPHeaderField: "Content-Type")
    switch method {
    case .post, .put:
      httpBody = try! JSONSerialization.data(withJSONObject: params, options: [])
    default:
      break
    }
  }
}
