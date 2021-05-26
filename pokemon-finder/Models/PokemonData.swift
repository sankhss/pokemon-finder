//
//  PokemonData.swift
//  pokemon-finder
//
//  Created by Samuel Henrique on 5/25/21.
//

import Foundation

struct PokemonData: Decodable {
  let id: Int
  let number: String
  let name: String
  let thumbnailImage: String
  let type: [String]
}
