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


final class HttpClient {
  private var baseUrl: String
  
  init(baseUrl: String) {
    self.baseUrl = baseUrl
  }
  
  func load(path: String, method: RequestMethod, params: [String: Any], completion: @escaping (Any?, ServiceError?) -> ()) -> URLSessionDataTask? {

    if !Reachability.isConnectedToNetwork() {
      completion(nil, ServiceError.noConnection)
      return nil
    }
    
    let request = URLRequest(baseUrl: baseUrl, path: path, method: method, params: params)
    
    let task = URLSession.shared.dataTask(with: request) { data, response, error in

      var object: Any? = nil
      if let data = data {
        object = try? JSONSerialization.jsonObject(with: data, options: [])
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
}
