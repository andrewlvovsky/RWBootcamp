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

import UIKit

class ViewController: UIViewController {
  @IBOutlet weak var targetLabel: UILabel!
  @IBOutlet weak var targetTextLabel: UILabel!
  @IBOutlet weak var guessLabel: UILabel!
  
  @IBOutlet weak var redLabel: UILabel!
  @IBOutlet weak var greenLabel: UILabel!
  @IBOutlet weak var blueLabel: UILabel!
  
  @IBOutlet weak var redSlider: UISlider!
  @IBOutlet weak var greenSlider: UISlider!
  @IBOutlet weak var blueSlider: UISlider!
  
  @IBOutlet weak var roundLabel: UILabel!
  @IBOutlet weak var scoreLabel: UILabel!

  let game = BullsEyeGame(currentValue: RGB(), targetValue: RGB(), score: 0, round: 0)
  var rgb = RGB()
  
  @IBAction func aSliderMoved(sender: UISlider) {
    rgb.r = Int(redSlider.value.rounded())
    rgb.g = Int(greenSlider.value.rounded())
    rgb.b = Int(blueSlider.value.rounded())
    game.currentValue = rgb

    updateView()
  }
  
  @IBAction func showAlert(sender: AnyObject) {
    let title, message: String
    (title, message) = game.calculateScore()

    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    let action = UIAlertAction(title: "OK", style: .default, handler: { _ in
      self.game.startNewRound()
      self.updateView()
    })
    alert.addAction(action)

    present(alert, animated: true, completion: nil)
  }
  
  @IBAction func startOver() {
    game.startNewGame()
    updateView()
  }
  
  func updateView() {
    redSlider.value = Float(game.currentValue.r)
    greenSlider.value = Float(game.currentValue.g)
    blueSlider.value = Float(game.currentValue.b)

    redLabel.text = String("R \(game.currentValue.r)")
    greenLabel.text = String("G \(game.currentValue.g)")
    blueLabel.text = String("B \(game.currentValue.b)")

    targetLabel.backgroundColor = UIColor(rgbStruct: game.targetValue)
    scoreLabel.text = String(game.score)
    roundLabel.text = String(game.round)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()

    rgb.r = Int(redSlider.value.rounded())
    rgb.g = Int(greenSlider.value.rounded())
    rgb.b = Int(blueSlider.value.rounded())

    game.currentValue = rgb
    startOver()
  }
}

