//
//  FavoriteTypeViewController.swift
//  pokemon-finder
//
//  Created by Samuel Henrique on 5/20/21.
//

import UIKit

class FavoriteTypeViewController: UIViewController {

  @IBOutlet weak var typeInputTextField: UITextField!
  override func viewDidLoad() {
        super.viewDidLoad()

    typeInputTextField.isUnderlinedField()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
