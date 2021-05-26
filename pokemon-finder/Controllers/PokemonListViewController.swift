//
//  PokemonListViewController.swift
//  pokemon-finder
//
//  Created by Samuel Henrique on 5/21/21.
//

import UIKit

class PokemonListViewController: UIViewController, PokemonListManagerDelegate, TypeListManagerDelegate {
  
  var favoriteType: Type?
  
  @IBOutlet weak var headerTitleLabel: UILabel!
  @IBOutlet weak var searchButton: UIButton!
  @IBOutlet weak var searchTextField: UITextField!
  @IBOutlet weak var typesCollectionView: UICollectionView!
  @IBOutlet weak var pokemonTableView: UITableView!
  @IBOutlet weak var sortByNameButton: UIButton!
  
  var sortType: SortType = .ascendingNumber
  
  var typeListManager = TypeListManager()
  var types: [Type] = []
  
  var pokemonListManager = PokemonListManager()
  var pokemons: [Pokemon] = []
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setDelegates()
    
    types = typeListManager.types
    pokemonListManager.loadWithFavorite(type: favoriteType)
    
    sortByNameButton.semanticContentAttribute = .forceRightToLeft
  }
  
  func didUpdatePokemonList(_ pokemonListManager: PokemonListManager, pokemonList: [Pokemon]) {
    pokemons = pokemonList
    pokemonTableView.reloadData()
  }
  
  func didUpdateTypeList(_ typeListManager: TypeListManager, typeList: [Type]) {
    types = typeList
    typesCollectionView.reloadData()
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
  
  @IBAction func sortByNameButtonPressed(_ sender: UIButton) {
    toggleSort()
  }
  
  func toggleSort() {
    if sortType == .ascendingName {
      sortType = .descendingName
      sortByNameButton.setImage(UIImage(systemName: "chevron.up"), for: .normal)
    } else {
      sortType = .ascendingName
      sortByNameButton.setImage(UIImage(systemName: "chevron.down"), for: .normal)
    }
    
    pokemonListManager.sort(pokemons, type: sortType)
  }
  
  func setDelegates() {
    pokemonListManager.delegate = self
    typeListManager.delegate = self
    
    typesCollectionView.delegate = self
    typesCollectionView.dataSource = self
    
    pokemonTableView.delegate = self
    pokemonTableView.dataSource = self
    
    searchTextField.delegate = self
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
    pokemonListManager.filterWith(type: types[indexPath.row])
  }
}

//MARK: - UITableView section

extension PokemonListViewController: UITableViewDelegate, UITableViewDataSource {
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return pokemons.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "pokemonCell", for: indexPath) as! PokemonTableViewCell
    cell.selectionStyle = .none
    
    let pokemon = pokemons[indexPath.row]
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
    searchFrom(textField: textField)
  }
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    searchTextField.endEditing(true)
  }
  
  @IBAction func searchTextChanged(_ sender: UITextField) {
    searchFrom(textField: sender)
  }
  
  func searchFrom(textField: UITextField) {
    if let name = textField.text {
      pokemonListManager.filterWith(name: name)
    } else {
      pokemonListManager.filterWith(type: favoriteType!)
    }
  }
}
