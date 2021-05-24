//
//  UnderlineTextField.swift
//  pokemon-finder
//
//  Created by Samuel Henrique on 5/21/21.
//

import UIKit

extension UITextField {
  func isUnderlinedField() {
    let bottomLine = CALayer()
    bottomLine.frame = CGRect(x: 0.0, y: self.frame.height - 1, width: self.frame.width, height: 1.0)
    bottomLine.backgroundColor = UIColor.white.cgColor
    self.borderStyle = UITextField.BorderStyle.none
    self.layer.addSublayer(bottomLine)
  }
}
