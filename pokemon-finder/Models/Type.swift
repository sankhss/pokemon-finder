//
//  Type.swift
//  pokemon-finder
//
//  Created by Samuel Henrique on 5/21/21.
//

import UIKit

struct Type {
  var name: String?
  var image: String?
  var selected: Bool = false
  
  var getIconSelection: UIImage? {
    return UIImage(named: selected ? "radio-on" : "radio-off")
  }
}

extension Type {
  init(data: TypeData) {
    self.name = data.name
    self.image = data.thumbnailImage
  }
}
