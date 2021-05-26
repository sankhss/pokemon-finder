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
  var type: [String]?
}

extension Pokemon {
  init(data: PokemonData) {
    self.id = data.id
    self.name = data.name
    self.image = data.thumbnailImage
    self.type = data.type
  }
}
