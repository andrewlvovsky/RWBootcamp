//
//  QuestionCodable.swift
//  jQuiz
//
//  Created by Jay Strawn on 7/17/20.
//  Copyright © 2020 Jay Strawn. All rights reserved.
//

import Foundation

struct Clue: Codable {
  var id: Int
  var answer: String
  var question: String
  var value: Int?
  var airdate: String
  var createdAt: String
  var updatedAt: String
  var categoryID: Int?
  var gameID: Int?
  var invalidCount: Int?
  var category: Category

  enum CodingKeys: String, CodingKey {
    case id
    case answer
    case question
    case value
    case airdate
    case createdAt = "created_at"
    case updatedAt = "updated_at"
    case categoryID = "category_id"
    case gameID = "game_id"
    case invalidCount = "invalid_count"
    case category
  }
}

struct Category: Codable {
  var id: Int
  var title: String
  var createdAt: String
  var updatedAt: String
  var cluesCount: Int

  enum CodingKeys: String, CodingKey {
    case id
    case title
    case createdAt = "created_at"
    case updatedAt = "updated_at"
    case cluesCount = "clues_count"
  }
}
