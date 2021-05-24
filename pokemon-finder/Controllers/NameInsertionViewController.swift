//
//  NameInsertionViewController.swift
//  pokemon-finder
//
//  Created by Samuel Henrique on 5/20/21.
//

import UIKit

class NameInsertionViewController: UIViewController, UITextFieldDelegate {

  @IBOutlet weak var nameInputTextField: UITextField!
  @IBOutlet weak var submitButton: UIButton!
  
  override func viewDidLoad() {
        super.viewDidLoad()
    
    nameInputTextField.isUnderlinedField()
    
    nameInputTextField.delegate = self
    submitButton.isHidden = true
    }
  
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
      textField.endEditing(true)
      return true
  }
  
  func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
    if textField.text == "" {
      textField.placeholder = "You must informe a name to continue"
    }
    return true
  }
  
  func textFieldDidEndEditing(_ textField: UITextField) {
    if textField.text != "" {
      submitButton.isHidden = false
    }
  }
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    nameInputTextField.endEditing(true)
  }
  
  @IBAction func submitButtonPressed(_ sender: UIButton) {
    performSegue(withIdentifier: "showTypeView", sender: self)
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    segue.destination.modalPresentationStyle = .fullScreen
    //dismiss(animated: true, completion: nil)
  }

}
