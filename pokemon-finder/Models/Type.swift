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
  var selected: Bool = false
}

extension Type {
  init(data: TypeData) {
    self.name = data.name
    self.image = data.thumbnailImage
  }
}
