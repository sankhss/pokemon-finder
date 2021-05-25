//
//  PokemonService.swift
//  pokemon-finder
//
//  Created by Samuel Henrique on 5/21/21.
//

import Foundation

class TypeService {
  private let client = HttpClient<TypeResultData>()
  
  @discardableResult
  func load(completion: @escaping ([Type]?, ServiceError?) -> ()) -> URLSessionDataTask? {
    
    return client.load(path: "/types.json") { result, error in
      completion(result?.results?.map(Type.init), error)
    }
  }
}
