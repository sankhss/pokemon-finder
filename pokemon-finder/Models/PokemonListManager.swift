//
//  PokemonListManager.swift
//  pokemon-finder
//
//  Created by Samuel Henrique on 5/26/21.
//

import UIKit

protocol PokemonListManagerDelegate {
  func didUpdatePokemonList(_ pokemonListManager: PokemonListManager, pokemonList: [Pokemon])
}

class PokemonListManager {
  static var pokemons: [Pokemon] = []

  var favoriteType: Type?
  
  var pokemonTask: URLSessionDataTask!
  
  var delegate: PokemonListManagerDelegate?
  
  func loadWithFavorite(type: Type?) {
    pokemonTask?.cancel()
    pokemonTask = PokemonService().load() {[weak self] pokemons, error in
      DispatchQueue.main.async {
        if let error = error {
          print(error.localizedDescription)
        } else if let pokemons = pokemons {
          PokemonListManager.pokemons = pokemons.unique
          if let favorite = type {
            self?.filterWith(type: favorite)
          }
        }
      }
    }
  }
  
  func filterWith(type: Type) {
    let filtered = PokemonListManager.pokemons.filter { pokemon in
      return pokemon.type?.contains(type.name!) ?? false
    }
    
    delegate?.didUpdatePokemonList(self, pokemonList: filtered)
  }
  
  func filterWith(name: String) {
    let filtered = PokemonListManager.pokemons.filter { pokemon in
      return pokemon.name?.hasPrefix(name) ?? false
    }
    
    delegate?.didUpdatePokemonList(self, pokemonList: filtered)
  }
  
}
