//
//  PokemonService.swift
//  pokemon-finder
//
//  Created by Samuel Henrique on 5/21/21.
//

import Foundation

class PokemonService {
  private let client = HttpClient(baseUrl: "https://vortigo.blob.core.windows.net/files/pokemon/data")
  
  @discardableResult
  func loadPokemons(completion: @escaping ([Pokemon]?, ServiceError?) -> ()) -> URLSessionDataTask? {
    
    return client.load(path: "/pokemons.json", method: .get, params: ["":""]) { result, error in
      let dictionaries = result as? [[String: Any]]
      completion(dictionaries?.compactMap(Pokemon.init), error)
    }
  }
}
