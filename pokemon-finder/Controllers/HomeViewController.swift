//
//  ViewController.swift
//  pokemon-finder
//
//  Created by Samuel Henrique on 5/20/21.
//

import UIKit

class HomeViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
  }

  @IBAction func startButtonPressed(_ sender: UIButton) {
    performSegue(withIdentifier: "showNameView", sender: self)
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    segue.destination.modalPresentationStyle = .fullScreen
    //dismiss(animated: true, completion: nil)
  }
}

