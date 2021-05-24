//
//  ServiceError.swift
//  pokemon-finder
//
//  Created by Samuel Henrique on 5/21/21.
//

import Foundation

enum ServiceError: Error {
  case noConnection
  case unexpected
  case other(String)
}

extension ServiceError: LocalizedError {
  var errorDescription: String? {
    switch self {
    case .noConnection:
      return "No Internet connection"
    case .unexpected:
      return "Something went wrong"
    case .other(let message):
      return message
    }
  }
}

extension ServiceError {
  init(json: [String: Any]) {
    if let message =  json["message"] as? String {
      self = .other(message)
    } else {
      self = .unexpected
    }
  }
}
