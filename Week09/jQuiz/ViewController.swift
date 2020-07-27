//
//  ViewController.swift
//  jQuiz
//
//  Created by Jay Strawn on 7/17/20.
//  Copyright © 2020 Jay Strawn. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  @IBOutlet weak var logoImageView: UIImageView!
  @IBOutlet weak var soundButton: UIButton!
  @IBOutlet weak var categoryLabel: UILabel!
  @IBOutlet weak var clueLabel: UILabel!
  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var scoreLabel: UILabel!

  var clues: [Clue] = []
  var correctAnswerClue: Clue?
  var points: Int = 0

  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.delegate = self
    tableView.dataSource = self
    tableView.separatorStyle = .none
    tableView.layer.backgroundColor = UIColor.clear.cgColor
    tableView.backgroundColor = .clear

    self.scoreLabel.text = "\(self.points)"

    if SoundManager.shared.isSoundEnabled == false {
      soundButton.setImage(UIImage(systemName: "speaker.slash"), for: .normal)
    } else {
      soundButton.setImage(UIImage(systemName: "speaker"), for: .normal)
    }

    getClues()

    if let imageURL = URL(string: "https://cdn1.edgedatg.com/aws/v2/abc/ABCUpdates/blog/2900129/8484c3386d4378d7c826e3f3690b481b/1600x900-Q90_8484c3386d4378d7c826e3f3690b481b.jpg"){
      logoImageView.load(url: imageURL)
    }

    SoundManager.shared.playSound()
  }

  func setUpView() {
    DispatchQueue.main.async {
      self.categoryLabel.text = self.clues.first?.category.title
      self.clueLabel.text = self.clues.first?.question
      self.tableView.reloadData()
    }
  }

  func getClues() {
    Networking.sharedInstance.getRandomCategory(completion: { (categoryId) in
      guard let id = categoryId else { return }
      Networking.sharedInstance.getAllCluesInCategory(categoryID: id) { (clues) in
        self.clues = clues
        self.setUpView()
      }
    })
  }

  @IBAction func didPressVolumeButton(_ sender: Any) {
    SoundManager.shared.toggleSoundPreference()
    if SoundManager.shared.isSoundEnabled == false {
      soundButton.setImage(UIImage(systemName: "speaker.slash"), for: .normal)
    } else {
      soundButton.setImage(UIImage(systemName: "speaker"), for: .normal)
    }
  }

}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return clues.count
  }

  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return UITableView.automaticDimension
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = UITableViewCell()
    cell.layer.backgroundColor = UIColor.clear.cgColor
    cell.backgroundColor = .clear
    cell.textLabel!.text = clues[indexPath.row].answer
    cell.textLabel!.textAlignment = .center
    return cell
  }

  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

  }
}

