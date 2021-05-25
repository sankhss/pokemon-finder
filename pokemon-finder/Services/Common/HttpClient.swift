//
//  HttpClient.swift
//  pokemon-finder
//
//  Created by Samuel Henrique on 5/21/21.
//

import UIKit


enum RequestMethod: String {
  case get = "GET"
  case post = "POST"
  case put = "PUT"
  case delete = "DELETE"
}


final class HttpClient<T: Decodable> {
  private var baseUrl: String
  
  init() {
    self.baseUrl = "https://vortigo.blob.core.windows.net/files/pokemon/data"
  }
  
  func load(path: String, completion: @escaping (T?, ServiceError?) -> ()) -> URLSessionDataTask? {

    if !Reachability.isConnectedToNetwork() {
      completion(nil, ServiceError.noConnection)
      return nil
    }
    
    if let url = URL(string: baseUrl + path) {
      let session = URLSession(configuration: .default)
      let task = session.dataTask(with: url) { data, response, error in
        if error != nil {
          print(error!)
          return
        }
        
        var object: T? = nil
        if let data = data {
          object = try? JSONDecoder().decode(T.self, from: data)
        }
        
        if let httpResponse = response as? HTTPURLResponse, (200..<300) ~= httpResponse.statusCode {
          completion(object, nil)
        } else {
          let error = (object as? [String: Any]).flatMap(ServiceError.init) ?? ServiceError.unexpected
          completion(nil, error)
        }
      }
      task.resume()
      return task
    }
    return nil
  }
}
