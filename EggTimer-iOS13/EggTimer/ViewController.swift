//
//  ViewController.swift
//  EggTimer
//


import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    var time = 0
    var counter = 0
    var timer = Timer()
    var player: AVAudioPlayer?
    
    let eggTimes = ["Soft": 300, "Medium": 420, "Hard": 540]
    
    @IBOutlet weak var progressBar: UIProgressView!
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        print(sender.currentTitle!)
        timer.invalidate()
        if(sender.currentTitle == "Soft"){
            time = eggTimes["Soft"]!
            counter = 300
        }
        else if (sender.currentTitle == "Medium"){
            time = eggTimes["Medium"]!
            counter = eggTimes["Medium"]!
        }
        else if (sender.currentTitle == "Hard") {
            time = eggTimes["Hard"]!
            counter = eggTimes["Hard"]!
        }
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
    }
    
    @objc func timerAction() {
        counter -= 1
        
        if(counter == 0){
            playSound()
            timer.invalidate()
        }
        updateProgeressBar()
    }
    
    func updateProgeressBar(){
        let timeProgress = time - counter
        let timePercentage = (Double(timeProgress)/Double(time))
        
        progressBar.progress = Float(timePercentage)
        print(timePercentage)
        
    }
    
    func playSound() {
        guard let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3") else { return }

        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)

            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)

            guard let player = player else { return }

            player.play()

        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    
}
