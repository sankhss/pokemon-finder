//
//  SequenceExtension.swift
//  pokemon-finder
//
//  Created by Samuel Henrique on 5/25/21.
//

import Foundation

extension Array where Element: Equatable {
  var unique: [Element] {
    var uniqueValues: [Element] = []
    forEach { item in
      guard !uniqueValues.contains(item) else { return }
      uniqueValues.append(item)
    }
    return uniqueValues
  }
}
