//
//  TypesPickerViewController.swift
//  pokemon-finder
//
//  Created by Samuel Henrique on 5/21/21.
//

import UIKit

class TypesPickerViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
  
  @IBOutlet weak var typeSelectionTableView: UITableView!
  
  var types: [Type] = []
  var task: URLSessionDataTask!
  
  var pickedType: Type?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    typeSelectionTableView.delegate = self
    typeSelectionTableView.dataSource = self
    
    task?.cancel()
    task = TypeService().load() {[weak self] types, error in
      DispatchQueue.main.async { 
        if let error = error {
          print(error.localizedDescription)
        } else if let types = types {
          self?.types = types
          self?.updateUI()
        }
      }
    }
  }
  
  func updateUI() {
    typeSelectionTableView.reloadData()
  }
  
  @IBAction func closeModalButtonPressed(_ sender: UIButton) {
    dismiss(animated: true, completion: nil)
  }
  
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
    
    let type = types[indexPath.row]
    cell.imageView?.load(from: type.image!)
    cell.typeNameLabel.text = type.name?.capitalized
    cell.typeIsSelectedButton.isEnabled = false
    if type.selected {
      cell.typeIsSelectedButton.setImage(UIImage(named: "radio-on"), for: .normal)
    } else {
      cell.typeIsSelectedButton.setImage(UIImage(named: "radio-off"), for: .normal)
    }
    return cell
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 50
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    unselectAllTypes()
    types[indexPath.row].selected = true
    pickedType = types[indexPath.row]
    updateUI()
  }
  
  func unselectAllTypes() {
    for i in 0..<types.count {
      types[i].selected = false
    }
  }
  
  
  @IBAction func confirmButtonPressed(_ sender: UIButton) {
    if let presenter = presentingViewController as? FavoriteTypeViewController {
      presenter.favoriteType = pickedType
      presenter.updateValue()
    }
    dismiss(animated: true, completion: nil)
  }
}
