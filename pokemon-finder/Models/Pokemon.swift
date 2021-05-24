//
//  Pokemon.swift
//  pokemon-finder
//
//  Created by Samuel Henrique on 5/21/21.
//

import Foundation

struct Pokemon {
  var id: Int
  var name: String?
  var image: String?
}

extension Pokemon {
  init?(_ json: [String: Any]) {
    guard let id = json["id"] as? Int else {
      return nil
    }
    
    self.id = id
    self.name = json["name"] as? String
    self.image = json["thumbnailImage"] as? String
  }
}
