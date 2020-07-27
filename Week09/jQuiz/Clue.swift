//
//  QuestionCodable.swift
//  jQuiz
//
//  Created by Jay Strawn on 7/17/20.
//  Copyright © 2020 Jay Strawn. All rights reserved.
//

import Foundation

struct Clue {
  var id: Int
  var answer: String
  var question: String
  var value: Int
  var airdate: Date
  var createdAt: Date
  var updatedAt: Date
  var categoryID: Int
  var gameID: Int?
  var invalidCount: Int?
  var category: Category
}

struct Category {
  var id: Int
  var title: String
  var createdAt: Date
  var updatedAt: Date
  var cluesCount: Int
}
