//
//  PokemonService.swift
//  pokemon-finder
//
//  Created by Samuel Henrique on 5/21/21.
//

import Foundation

class PokemonService {
  private let client = HttpClient<[PokemonData]>()
  
  @discardableResult
  func load(completion: @escaping ([Pokemon]?, ServiceError?) -> ()) -> URLSessionDataTask? {
    
    return client.load(path: "/pokemons.json") { result, error in
      completion(result?.compactMap(Pokemon.init), error)
    }
  }
}
