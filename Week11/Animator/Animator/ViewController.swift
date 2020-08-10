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

  @IBOutlet weak var animationObject: UIView!

  @IBOutlet weak var roundConstraint: NSLayoutConstraint!
  @IBOutlet weak var scaleConstraint: NSLayoutConstraint!
  @IBOutlet weak var rotateConstraint: NSLayoutConstraint!
  @IBOutlet weak var playConstraint: NSLayoutConstraint!

  let buttonSize: CGFloat = 50
  var menuToggled = true
  var currentScale: CGFloat = 1
  var currentAngle: CGFloat = .pi
  var animationDuration = 0
  let animator = UIViewPropertyAnimator(duration: 2, curve: .easeInOut)

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.

    // Hack to round buttons
    menuButton.layer.cornerRadius = menuButton.intrinsicContentSize.width / 2
    playButton.layer.cornerRadius = playButton.intrinsicContentSize.width / 2
    roundButton.layer.cornerRadius = roundButton.intrinsicContentSize.width / 2
    scaleUpButton.layer.cornerRadius = scaleUpButton.intrinsicContentSize.width / 2
    rotateRightButton.layer.cornerRadius = rotateRightButton.intrinsicContentSize.width / 2

    toggleMenu(self)

    // Brings main menu button to the front of all the other views in the scene
    self.view.bringSubviewToFront(menuButton)
  }

  @IBAction func toggleMenu(_ sender: Any) {
    UIView.animate(
      withDuration: 0.5,
      delay: 0,
      usingSpringWithDamping: self.menuToggled ? 0.7 : 0.4,
      initialSpringVelocity: 0,
      options: [.allowUserInteraction],
      animations: {
        self.rotateConstraint.constant = self.menuToggled ? -self.buttonSize : self.buttonSize / 4
        self.scaleConstraint.constant = self.menuToggled ? -self.buttonSize : self.buttonSize / 4
        self.roundConstraint.constant = self.menuToggled ? -self.buttonSize : self.buttonSize / 4
        self.playConstraint.constant = self.menuToggled ? -self.buttonSize : self.buttonSize / 4
        self.view.layoutIfNeeded()

        self.menuToggled = !self.menuToggled
    }, completion: nil)
  }

  @IBAction func scaleUpAnimation(_ sender: Any) {
    animator.addAnimations({
      self.animationObject.transform = CGAffineTransform(
        scaleX: self.currentScale * 1.5,
        y: self.currentScale * 1.5)
      self.currentScale = self.currentScale * 1.5
      self.view.layoutIfNeeded()
    }, delayFactor: 1)
    print("Scale animation added to queue")
  }

  @IBAction func roundEdgeAnimation(_ sender: Any) {
    animator.addAnimations({
      self.animationObject.layer.cornerRadius = self.animationObject.frame.width / 2
      self.view.layoutIfNeeded()
    }, delayFactor: 1)
    print("Round animation added to queue")
  }

  @IBAction func rotateAnimation(_ sender: Any) {
    animator.addAnimations({
      self.animationObject.transform = CGAffineTransform(
        rotationAngle: self.currentAngle / 2
      )
      self.currentAngle = self.currentAngle * 2
      self.view.layoutIfNeeded()
    }, delayFactor: 1)
    print("Rotate animation added to queue")
  }

  @IBAction func playAnimations(_ sender: Any) {
    menuButton.isEnabled = false
    if menuToggled {
      toggleMenu(self)
    }
    animator.addCompletion { _ in self.menuButton.isEnabled = true}
    animator.startAnimation()
  }
}

