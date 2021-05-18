//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

var player: AVAudioPlayer?

class ViewController: UIViewController {
    @IBOutlet weak var textu: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    let softTime = 5
    let mediumTime = 7
    let hardTime = 12
    
    let eggTimes = ["Soft": 3, "Medium": 4, "Hard": 7]
    
    //class ViewController: UIViewController {
    var secondsRemaining = 60

    var timer = Timer()
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        let hardness = sender.currentTitle!
        let progress: Int = eggTimes[hardness]!
        self.textu.text = hardness
        
        timer.invalidate()
        
        //print(eggTimes[hardness]!)
        secondsRemaining = eggTimes[hardness]!
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { (Timer) in
                if self.secondsRemaining > 0 {
                    print ("\(self.secondsRemaining) seconds")
                    self.progressBar.progress = 1 - Float(self.secondsRemaining)/Float(progress)
                    self.secondsRemaining -= 1
                } else {
                    self.textu.text = "Done"
                    self.progressBar.progress = 1
                    
                    guard let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3") else { return }

                       do {
                           try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
                           try AVAudioSession.sharedInstance().setActive(true)

                           /* The following line is required for the player to work on iOS 11. Change the file type accordingly*/
                           player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)

                           /* iOS 10 and earlier require the following line:
                           player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileTypeMPEGLayer3) */

                           guard let player = player else { return }

                           player.play()

                       } catch let error {
                           print(error.localizedDescription)
                       }
                }
            }
    }
    

}


