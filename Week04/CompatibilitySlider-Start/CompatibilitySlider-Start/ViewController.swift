//
//  ViewController.swift
//  CompatibilitySlider-Start
//
//  Created by Jay Strawn on 6/16/20.
//  Copyright © 2020 Jay Strawn. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  @IBOutlet weak var compatibilityItemLabel: UILabel!
  @IBOutlet weak var slider: UISlider!
  @IBOutlet weak var questionLabel: UILabel!

  var compatibilityItems = ["Cats", "Dogs"] // Add more!
  var currentItemIndex = 0

  var person1 = Person(id: 1, items: [:])
  var person2 = Person(id: 2, items: [:])
  var currentPerson: Person?

  override func viewDidLoad() {
    super.viewDidLoad()
    currentPerson = person1
    updateLabels()
  }

  @IBAction func sliderValueChanged(_ sender: UISlider) {
    print(sender.value)
  }

  func displayScore(of score: String) {
    let alert = UIAlertController(title: "Results", message: "Your score is \(score)", preferredStyle: UIAlertController.Style.alert)

    alert.addAction(UIAlertAction(title: "Ok", style: .default, handler:{ (UIAlertAction) in
      self.currentPerson = self.person1
      self.currentItemIndex = 0
      self.updateLabels()
    }))

    self.present(alert, animated: true, completion: nil)
  }

  @IBAction func didPressNextItemButton(_ sender: Any) {
    if currentItemIndex < compatibilityItems.count - 1 {
      let currentItem = compatibilityItems[currentItemIndex]
      currentPerson?.items.updateValue(slider.value, forKey: currentItem)
      currentItemIndex += 1
    } else if currentPerson == person2 {
      let score = calculateCompatibility()
      displayScore(of: score)
    } else {
      currentPerson = currentPerson == person1 ? person2 : person1
      currentItemIndex = 0
    }
    updateLabels()
  }

  func updateLabels() {
    if let person = currentPerson {
      questionLabel.text = "Person \(String(person.id)), what do you think about..."
      compatibilityItemLabel.text = compatibilityItems[currentItemIndex]
      slider.value = 2.5
    }
  }

  func calculateCompatibility() -> String {
    // If diff 0.0 is 100% and 5.0 is 0%, calculate match percentage
    var percentagesForAllItems: [Double] = []

    for (key, person1Rating) in person1.items {
      let person2Rating = person2.items[key] ?? 0
      let difference = abs(person1Rating - person2Rating)/5.0
      percentagesForAllItems.append(Double(difference))
    }

    let sumOfAllPercentages = percentagesForAllItems.reduce(0, +)
    let matchPercentage = sumOfAllPercentages/Double(compatibilityItems.count)
    print(matchPercentage, "%")
    let matchString = 100 - (matchPercentage * 100).rounded()
    return "\(matchString)%"
  }

}

