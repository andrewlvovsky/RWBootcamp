//
//  NetworkingHandler.swift
//  jQuiz
//
//  Created by Jay Strawn on 7/17/20.
//  Copyright © 2020 Jay Strawn. All rights reserved.
//

import Foundation

class Networking {

  static let sharedInstance = Networking()

  func getRandomCategory(completion: @escaping (Int?) -> Void) {
    guard let randomURL = URL(string: "http://www.jservice.io/api/random") else {
      fatalError()
    }

    URLSession.shared.dataTask(with: randomURL) { (data, response, error) in
      guard let httpResponse = response as? HTTPURLResponse,
        (200..<300).contains(httpResponse.statusCode),
        let data = data else {
          return
      }
      do {
        let result = try JSONDecoder().decode(Array<Clue>.self, from: data)
        print(result)
        completion(result.first?.category_id ?? nil)
      } catch {
        print("Unable to decode: \(error)")
      }

    }.resume()

  }

  func getAllCluesInCategory(categoryID: Int?, clues: ([Clue]) -> Void) {

  }

}
