//
//  FavoriteTypeViewController.swift
//  pokemon-finder
//
//  Created by Samuel Henrique on 5/20/21.
//

import UIKit

class FavoriteTypeViewController: UIViewController {
  
  @IBOutlet weak var typeInputTextField: UITextField!
  @IBOutlet weak var greetingLabel: UILabel!
  
  var trainerName: String?
  
  var favoriteType: Type?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    if let name = trainerName {
      greetingLabel.text = "Hello, \(name)!"
    }
    
    typeInputTextField.isUnderlinedField()
  }
  
  @IBAction func selectTypeButtonPressed(_ sender: UIButton) {
    performSegue(withIdentifier: "presentTypesModal", sender: self)
  }
  
  func updateValue() {
    typeInputTextField.text = favoriteType?.name?.capitalized
  }
  
  @IBAction func submitButtonPressed(_ sender: UIButton) {
    
    performSegue(withIdentifier: "showPokemonList", sender: self)
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "showPokemonList" {
      segue.destination.modalPresentationStyle = .fullScreen
      (segue.destination as! PokemonListViewController).favoriteType = favoriteType
    }
  }
}
