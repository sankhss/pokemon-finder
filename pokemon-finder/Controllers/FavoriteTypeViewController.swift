//
//  FavoriteTypeViewController.swift
//  pokemon-finder
//
//  Created by Samuel Henrique on 5/20/21.
//

import UIKit

class FavoriteTypeViewController: UIViewController {
  
  @IBOutlet weak var typeInputTextField: UITextField!
  
  var favoriteType: Type?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
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
   // Get the new view controller using segue.destination.
   // Pass the selected object to the new view controller.
   }
  
}
