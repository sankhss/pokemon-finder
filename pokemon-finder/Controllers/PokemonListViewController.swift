//
//  PokemonListViewController.swift
//  pokemon-finder
//
//  Created by Samuel Henrique on 5/21/21.
//

import UIKit

class PokemonListViewController: UIViewController {
  
  @IBOutlet weak var headerTitleLabel: UILabel!
  @IBOutlet weak var searchButton: UIButton!
  @IBOutlet weak var searchTextField: UITextField!
  @IBOutlet weak var typesCollectionView: UICollectionView!
  @IBOutlet weak var pokemonTableView: UITableView!
  
  var pokemons: [Pokemon] = []
  var pokemonsByType: [Pokemon] = []
  
  var types: [Type] = []
  var favoriteType: Type?

  var typesTask: URLSessionDataTask!
  var pokemonTask: URLSessionDataTask!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    typesCollectionView.delegate = self
    typesCollectionView.dataSource = self
    
    pokemonTableView.delegate = self
    pokemonTableView.dataSource = self
    
    searchTextField.delegate = self
    
    updateTypes()
    updatePokemons()
  }
  
  func updateTypes() {
    typesTask?.cancel()
    typesTask = TypeService().load() {[weak self] types, error in
      DispatchQueue.main.async {
        if let error = error {
          print(error.localizedDescription)
        } else if let types = types {
          self?.types = types
          self?.updateTypesCollection()
        }
      }
    }
  }
  
  func updatePokemons() {
    pokemonTask?.cancel()
    pokemonTask = PokemonService().load() {[weak self] pokemons, error in
      DispatchQueue.main.async {
        if let error = error {
          print(error.localizedDescription)
        } else if let pokemons = pokemons {
          self?.pokemons = pokemons.unique
          if let favorite = self?.favoriteType {
            self?.filterWith(type: favorite)
          }
          self?.updatePokemonsList()
        }
      }
    }
  }
  
  @IBAction func searchButtonPressed(_ sender: UIButton) {
    toggleSearch()
  }
  
  func toggleSearch() {
    searchTextField.isHidden = !searchTextField.isHidden
    searchButton.isHidden = !searchButton.isHidden
    headerTitleLabel.isHidden = !headerTitleLabel.isHidden
    
    if searchTextField.isHidden == false {
      searchTextField.becomeFirstResponder()
    }
  }
  
  func updateTypesCollection() {
    typesCollectionView.reloadData()
  }
  
  func updatePokemonsList() {
    pokemonTableView.reloadData()
  }
  
  func filterWith(type: Type) {
    pokemonsByType = pokemons.filter { pokemon in
      return pokemon.type?.contains(type.name!) ?? false
    }
    
    updatePokemonsList()
  }
  
  func filterWith(name: String) {
    pokemonsByType = pokemons.filter { pokemon in
      return pokemon.name?.hasPrefix(name) ?? false
    }
    
    updatePokemonsList()
  }
}

//MARK: - UICollectionView section

extension PokemonListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return types.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "typeCollectionCell", for: indexPath) as! TypeCollectionViewCell
    
    let type = types[indexPath.row]
    cell.typeImageView?.load(from: type.image!)
    cell.typeNameLabel.text = type.name?.capitalized
    
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    filterWith(type: types[indexPath.row])
  }
}

//MARK: - UITableView section

extension PokemonListViewController: UITableViewDelegate, UITableViewDataSource {
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return pokemonsByType.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "pokemonCell", for: indexPath) as! PokemonTableViewCell
    cell.selectionStyle = .none
    
    let pokemon = pokemonsByType[indexPath.row]
    cell.pokemonImageView?.load(from: pokemon.image!)
    cell.pokemonNameLabel.text = pokemon.name?.capitalized
   
    return cell
  }
}

//MARK: - UITextField section

extension PokemonListViewController: UITextFieldDelegate {
  
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    searchTextField.endEditing(true)
    return true
  }
  
  func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
    return true
  }
  
  func textFieldDidEndEditing(_ textField: UITextField) {
    if let name = textField.text {
      filterWith(name: name)
    } else {
      filterWith(type: favoriteType!)
    }
  }
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    searchTextField.endEditing(true)
  }
  
  @IBAction func searchTextChanged(_ sender: UITextField) {
    if let name = sender.text {
      filterWith(name: name)
    } else {
      filterWith(type: favoriteType!)
    }
  }
}
