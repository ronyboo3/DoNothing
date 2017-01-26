//
//  ViewController.swift
//  DoNothing
//
//  Created by 棚瀬 隆太 on 2016/11/10.
//  Copyright © 2016年 棚瀬 隆太. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    @IBOutlet weak var button: UIButton!
    var buttonEnabled = true
    
    var audioPlayer: AVAudioPlayer?
    var bgmPlayer: AVAudioPlayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        set()
        
        guard let buttonSoundPath = Bundle.main.path(forResource: "button", ofType: "mp3"),
            let bgmPath = Bundle.main.path(forResource: "bgm", ofType: "mp3") else {
            return
        }
        
        let buttonSoundUrl = URL(fileURLWithPath: buttonSoundPath)
        let bgmUrl = URL(fileURLWithPath: bgmPath)
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: buttonSoundUrl)
            audioPlayer?.prepareToPlay()
            audioPlayer?.volume = 3.0
            bgmPlayer = try AVAudioPlayer(contentsOf: bgmUrl)
            bgmPlayer?.prepareToPlay()
            bgmPlayer?.numberOfLoops = -1
            bgmPlayer?.play()
        } catch {}
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func returnAction(segue: UIStoryboardSegue) {}
    
    func set() {
        button.setImage(UIImage(named: "pushButton_maru.png"), for: .normal)
        button.setImage(UIImage(named: "pushButton_maru_h.png"), for: .highlighted)
    }

    @IBAction func tappedButton(_ sender: UIButton) {
        if !buttonEnabled {
            return
        }
        
        audioPlayer?.play()
        button.setImage(UIImage(named: "pushButton_maru_h.png"), for: .normal)
        buttonEnabled = false
        enableButton()
    }
    
    func enableButton() {
        let n = arc4random() % 10 + 1
        let delay = Double(n) * Double(NSEC_PER_SEC)
        let time  = DispatchTime.now() + Double(Int64(delay)) / Double(NSEC_PER_SEC)
        DispatchQueue.main.asyncAfter(deadline: time, execute: {
            self.audioPlayer?.play()
            self.button.setImage(UIImage(named: "pushButton_maru.png"), for: .normal)
            self.buttonEnabled = true
        })
    }

}

