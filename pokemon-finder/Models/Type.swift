//
//  Type.swift
//  pokemon-finder
//
//  Created by Samuel Henrique on 5/21/21.
//

import Foundation

struct Type {
  var name: String?
  var image: String?
}

extension Type {
  init?(json: [String: Any]) {
    guard let name = json["name"] as? String else {
      return nil
    }
    
    self.name = name
    self.image = json["email"] as? String
    self.name = json["thumbnailImage"] as? String
  }
}
