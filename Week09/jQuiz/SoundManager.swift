//
//  SoundManager.swift
//  jQuiz
//
//  Created by Jay Strawn on 7/17/20.
//  Copyright © 2020 Jay Strawn. All rights reserved.
//

//import Foundation
import AVFoundation

class SoundManager: NSObject {

  static let shared = SoundManager()

  private var player: AVAudioPlayer?

  var isSoundEnabled: Bool? {
    get {
      // Since UserDefaults.standard.bool(forKey: "sound") will default to "false" if it has not been set
      // You might want to use `object`, because if an object has not been set yet it will be nil
      // Then if it's nil you know it's the user's first time launching the app
      UserDefaults.standard.object(forKey: "sound") as? Bool
    }
    set {
      UserDefaults.standard.set(newValue, forKey: "sound")
    }
  }

  func playSound() {
    guard let url = Bundle.main.url(forResource: "Jeopardy-theme-song", withExtension: "mp3") else { return }

    do {
      try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
      try AVAudioSession.sharedInstance().setActive(true)
      player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
    } catch let error {
      print(error.localizedDescription)
    }

    if let player = player,
      let isSoundEnabled = isSoundEnabled {
      if isSoundEnabled {
        player.play()
        player.numberOfLoops = -1
      }
    }
  }

  func toggleSoundPreference() {
    if let player = player,
      let isSoundEnabled = isSoundEnabled{
      self.isSoundEnabled = !isSoundEnabled
      if self.isSoundEnabled! {
        player.play()
      } else {
        player.stop()
      }
    }
  }

}
