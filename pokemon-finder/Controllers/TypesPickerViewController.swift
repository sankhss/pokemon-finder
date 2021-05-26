//
//  TypesPickerViewController.swift
//  pokemon-finder
//
//  Created by Samuel Henrique on 5/21/21.
//

import UIKit

class TypesPickerViewController: UIViewController, TypeListManagerDelegate {
  
  @IBOutlet weak var typeSelectionTableView: UITableView!
  @IBOutlet weak var confirmButton: UIButton!
  
  var typeListManager = TypeListManager()
  var types: [Type] = []
  
  var pickedType: Type?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setDelegates()
    
    types = typeListManager.types
    confirmButton.isEnabled = false
    confirmButton.backgroundColor = .lightGray
  }
  
  func didUpdateTypeList(_ typeListManager: TypeListManager, typeList: [Type]) {
    types = typeList
    typeSelectionTableView.reloadData()
  }
  
  @IBAction func closeModalButtonPressed(_ sender: UIButton) {
    dismiss(animated: true, completion: nil)
  }
  
  func setDelegates() {
    typeListManager.delegate = self
    
    typeSelectionTableView.delegate = self
    typeSelectionTableView.dataSource = self
  }
  
  @IBAction func confirmButtonPressed(_ sender: UIButton) {
    if let presenter = presentingViewController as? FavoriteTypeViewController {
      presenter.favoriteType = pickedType
      presenter.updateValue()
    }
    dismiss(animated: true, completion: nil)
  }
}

//MARK: - UITableView section

extension TypesPickerViewController: UITableViewDelegate, UITableViewDataSource {
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    return 70
  }
  
  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    let headerView = UIView()
    if let headerCell = tableView.dequeueReusableCell(withIdentifier: "typesHeaderCell") {
      headerView.backgroundColor = .white
      headerView.addSubview(headerCell)
    }
    return headerView
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return types.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "typeCell", for: indexPath) as! TypeTableViewCell
    cell.selectionStyle = .none
    
    let type = types[indexPath.row]
    cell.imageView?.load(from: type.image!)
    cell.typeNameLabel.text = type.name?.capitalized
    cell.typeIsSelectedButton.isEnabled = false
    cell.typeIsSelectedButton.setImage(type.getIconSelection, for: .normal)
    
    return cell
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 50
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    typeListManager.unselectAllTypes()
    types[indexPath.row].selected = true
    pickedType = types[indexPath.row]
    confirmButton.isEnabled = true
    confirmButton.backgroundColor = #colorLiteral(red: 0.9450980392, green: 0.1174988821, blue: 0.4629961252, alpha: 1)
  }
}
