//
//  ViewController.swift
//  Animator
//
//  Created by Andrew Lvovsky on 8/10/20.
//  Copyright © 2020 Andrew Lvovsky. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  @IBOutlet weak var menuButton: UIButton!
  @IBOutlet weak var playButton: UIButton!
  @IBOutlet weak var roundButton: UIButton!
  @IBOutlet weak var scaleUpButton: UIButton!
  @IBOutlet weak var rotateRightButton: UIButton!

  @IBOutlet weak var roundConstraint: NSLayoutConstraint!
  @IBOutlet weak var scaleConstraint: NSLayoutConstraint!
  @IBOutlet weak var rotateConstraint: NSLayoutConstraint!
  @IBOutlet weak var playConstraint: NSLayoutConstraint!

  let buttonSize: CGFloat = 50
  var menuToggled = false

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    menuButton.layer.cornerRadius = menuButton.intrinsicContentSize.width / 2
    playButton.layer.cornerRadius = playButton.intrinsicContentSize.width / 2
    roundButton.layer.cornerRadius = roundButton.intrinsicContentSize.width / 2
    scaleUpButton.layer.cornerRadius = scaleUpButton.intrinsicContentSize.width / 2
    rotateRightButton.layer.cornerRadius = rotateRightButton.intrinsicContentSize.width / 2

    self.rotateConstraint.constant = -buttonSize
    self.scaleConstraint.constant = -buttonSize
    self.roundConstraint.constant = -buttonSize
    self.playConstraint.constant = -buttonSize

    self.view.bringSubviewToFront(menuButton)
  }

  @IBAction func toggleMenu(_ sender: Any) {
    UIView.animate(
      withDuration: 0.5,
      delay: 0,
      usingSpringWithDamping: self.menuToggled ? 0.7 : 0.4,
      initialSpringVelocity: 0,
      options: [],
      animations: {
        self.rotateConstraint.constant = self.menuToggled ? -self.buttonSize : self.buttonSize / 4
        self.scaleConstraint.constant = self.menuToggled ? -self.buttonSize : self.buttonSize / 4
        self.roundConstraint.constant = self.menuToggled ? -self.buttonSize : self.buttonSize / 4
        self.playConstraint.constant = self.menuToggled ? -self.buttonSize : self.buttonSize / 4
        self.view.layoutIfNeeded()

        self.menuToggled = !self.menuToggled
    },
      completion: nil)
  }
}

