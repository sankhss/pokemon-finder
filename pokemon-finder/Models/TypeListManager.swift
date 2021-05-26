//
//  TypeListManager.swift
//  pokemon-finder
//
//  Created by Samuel Henrique on 5/26/21.
//

import Foundation

protocol TypeListManagerDelegate {
  func didUpdateTypeList(_ typeListManager: TypeListManager, typeList: [Type])
}

class TypeListManager {
  static var cached: [Type]?
  
  var typesTask: URLSessionDataTask!
  
  var delegate: TypeListManagerDelegate?
  
  var types: [Type] {
    if let types = TypeListManager.cached {
      return types
    } else {
      load()
      return []
    }
  }
  
  func load() {
    typesTask?.cancel()
    typesTask = TypeService().load() { types, error in
      DispatchQueue.main.async {
        if let error = error {
          print(error.localizedDescription)
        } else if let types = types {
          TypeListManager.cached = types
          self.delegate?.didUpdateTypeList(self, typeList: types)
        }
      }
    }
  }
  
  func unselectAllTypes() {
    var types = self.types
    for i in 0..<types.count {
      types[i].selected = false
    }
    self.delegate?.didUpdateTypeList(self, typeList: types)
  }
}
