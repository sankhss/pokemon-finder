//
//  URLExtension.swift
//  pokemon-finder
//
//  Created by Samuel Henrique on 5/21/21.
//

import Foundation

extension URL {
  init(baseUrl: String, path: String, params: [String: Any], method: RequestMethod) {
    var components = URLComponents(string: baseUrl)!
    components.path += path
    
    switch method {
    case .get, .delete:
      components.queryItems = params.map {
        URLQueryItem(name: $0.key, value: String(describing: $0.value))
      }
    default:
      break
    }
    
    self = components.url!
  }
}
