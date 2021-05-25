//
//  TypeData.swift
//  pokemon-finder
//
//  Created by Samuel Henrique on 5/25/21.
//

import Foundation

struct TypeResultData: Decodable {
  let results: [TypeData]?
}

struct TypeData: Decodable {
  let thumbnailImage: String
  let name: String
}
