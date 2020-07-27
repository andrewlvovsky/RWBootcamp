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

  private var players: [AVAudioPlayer]

  override init() {
    players = []
    for _ in 0..<3 {
      self.players.append(AVAudioPlayer())
    }
    super.init()
  }

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

  func playSound(of url: URL, on index: Int) {
    do {
      players[index] = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
    } catch let error {
      print(error.localizedDescription)
    }

    if let isSoundEnabled = isSoundEnabled {
      if isSoundEnabled {
        players[index].play()
        if index == 0 {
          players[index].numberOfLoops = -1
        }
      }
    }
  }

  func toggleSoundPreference() {
    if let isSoundEnabled = isSoundEnabled {
      self.isSoundEnabled = !isSoundEnabled
      let mainPlayer = players[0]
      if self.isSoundEnabled! {
        mainPlayer.play()
      } else {
        mainPlayer.stop()
      }
    }
  }

}
