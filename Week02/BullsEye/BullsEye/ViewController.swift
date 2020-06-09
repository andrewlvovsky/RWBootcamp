//
//  ViewController.swift
//  BullsEye
//
//  Created by Ray Wenderlich on 6/13/18.
//  Copyright © 2018 Ray Wenderlich. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  //  var currentValue = 0
  //  var targetValue = 0
  //  var score = 0
  //  var round = 0
  var game = BullsEyeGame(currentValue: 0, targetValue: 0, score: 0, round: 0)

  @IBOutlet weak var slider: UISlider!
  @IBOutlet weak var targetLabel: UILabel!
  @IBOutlet weak var scoreLabel: UILabel!
  @IBOutlet weak var roundLabel: UILabel!

  override func viewDidLoad() {
    super.viewDidLoad()
    let roundedValue = slider.value.rounded()
    game.currentValue = Int(roundedValue)
    game.startNewGame()
  }

  @IBAction func showAlert() {
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

  @IBAction func sliderMoved(_ slider: UISlider) {
    let roundedValue = slider.value.rounded()
    game.currentValue = Int(roundedValue)
  }

  func updateView() {
    slider.value = Float(game.currentValue)
    targetLabel.text = String(game.targetValue)
    scoreLabel.text = String(game.score)
    roundLabel.text = String(game.round)
  }

  @IBAction func startNewGame() {
    game.startNewGame()
    updateView()
  }

}
