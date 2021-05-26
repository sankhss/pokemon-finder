//
//  TypeTableViewCell.swift
//  pokemon-finder
//
//  Created by Samuel Henrique on 5/25/21.
//

import UIKit

class TypeTableViewCell: UITableViewCell {
  @IBOutlet weak var typeImageView: UIImageView!
  @IBOutlet weak var typeNameLabel: UILabel!
  @IBOutlet weak var typeIsSelectedButton: UIButton!
  
  @IBAction func typeSelectButtonPressed(_ sender: UIButton) {
  }
}
