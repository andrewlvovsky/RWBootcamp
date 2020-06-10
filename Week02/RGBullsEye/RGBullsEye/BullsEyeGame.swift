/*
* Copyright (c) 2015 Razeware LLC
*
* Permission is hereby granted, free of charge, to any person obtaining a copy
* of this software and associated documentation files (the "Software"), to deal
* in the Software without restriction, including without limitation the rights
* to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
* copies of the Software, and to permit persons to whom the Software is
* furnished to do so, subject to the following conditions:
*
* The above copyright notice and this permission notice shall be included in
* all copies or substantial portions of the Software.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
* AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
* LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
* OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
* THE SOFTWARE.
*/

import Foundation

class BullsEyeGame {  // might be class?
  var currentValue: RGB
  var targetValue: RGB
  var score: Int
  var round: Int

  init(currentValue: RGB, targetValue: RGB, score: Int, round: Int) {
    self.currentValue = currentValue
    self.targetValue = targetValue
    self.score = score
    self.round = round
  }

  func calculateScore() -> (String, String) {
    let difference = Int(currentValue.difference(target: targetValue) * 255)
    var points = 255 - difference

    let title: String
    if difference == 0 {
      title = "Perfect!"
      points += 1000
    } else if difference < 50 {
      title = "You almost had it!"
      if difference <= 10 {
        points += 500
      }
    } else if difference < 100 {
      title = "Pretty good!"
    } else {
      title = "Not even close..."
    }

    score += points

    let message = "You scored \(points) points"

    return (title, message)
  }

  func startNewRound() {
    round += 1
    currentValue = RGB()
    targetValue.r = Int.random(in: 1...255)
    targetValue.g = Int.random(in: 1...255)
    targetValue.b = Int.random(in: 1...255)
  }

  func startNewGame() {
    score = 0
    round = 0
    startNewRound()
  }
}
