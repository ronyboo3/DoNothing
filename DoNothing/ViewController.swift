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
    
    var timerForVibrate = Timer()
    var timerForAlarm = Timer()
    var timerForButtonAction = Timer()
    
    var stopVibrate = false
    var isFirstButtonTap = true
    
    var actionTime: CGFloat = 0
    
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        GATrackingManager.sendScreenTracking(screenName: "メイン")
        
        if let _ = UserDefaults.sharedInstance.fetchIsSetAlarm() {
            timerForAlarm = Timer.scheduledTimer(timeInterval: 60, target: self, selector: #selector(self.checkAlarm(_:)), userInfo: nil, repeats: true)
            timerForAlarm.fire()
        }
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
    
    func checkAlarm(_ sender: Timer) {
        guard let setTime = UserDefaults.sharedInstance.fetchAlarmTime() else {
            return
        }
        
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        if setTime == formatter.string(from: Date()) {
            callAlarm()
        }
    }
    
    func callAlarm() {
        timerForVibrate = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.vibrate(_:)), userInfo: nil, repeats: true)
        timerForVibrate.fire()
        
        let ac = UIAlertController(title: "アラーム", message: "おはようございます", preferredStyle: .alert)
        let okAction: UIAlertAction = UIAlertAction(title: "OK", style: .default, handler:{
            (action: UIAlertAction!) -> Void in
            self.timerForVibrate.invalidate()
            self.timerForAlarm.invalidate()
            self.stopVibrate = true
            UserDefaults.sharedInstance.removeIsSetAlarm()
        })
        ac.addAction(okAction)
        present(ac, animated: true, completion: nil)
    }
    
    func vibrate(_ sender: Timer) {
        if stopVibrate {
            return
        }
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
    }

    @IBAction func tappedButton(_ sender: UIButton) {
        if !buttonEnabled {
            return
        }
        
        audioPlayer?.play()
        button.setImage(UIImage(named: "pushButton_maru_h.png"), for: .normal)
        buttonEnabled = false
        saveTotalTapCount()
        saveCurrentTapCount()
        enableButton()
    }
    
    func saveCurrentTapCount() {
        guard let count = UserDefaults.sharedInstance.fetchCurrentTap() else {
            UserDefaults.sharedInstance.saveCurrentTap(count: 1)
            return
        }
        UserDefaults.sharedInstance.saveCurrentTap(count: count + 1)
    }
    
    func saveTotalTapCount() {
        guard let count = UserDefaults.sharedInstance.fetchTotalTap() else {
            UserDefaults.sharedInstance.saveTotalTap(count: 1)
            return
        }
        UserDefaults.sharedInstance.saveTotalTap(count: count + 1)
    }
    
    func enableButton() {
        timerForButtonAction.invalidate()
        if !isFirstButtonTap {
            if let fastestTime = UserDefaults.sharedInstance.fetchFastestTapTime(),
                let latestTime = UserDefaults.sharedInstance.fetchLatestTapTime() {
                if fastestTime > actionTime {
                    UserDefaults.sharedInstance.saveFastestTapTime(time: actionTime)
                } else if latestTime < actionTime {
                    UserDefaults.sharedInstance.saveLatestTapTime(time: actionTime)
                }
            } else {
                UserDefaults.sharedInstance.saveFastestTapTime(time: actionTime)
                UserDefaults.sharedInstance.saveLatestTapTime(time: actionTime)
            }
        }
        isFirstButtonTap = false
        
        let n = arc4random() % 10 + 1
        let delay = Double(n) * Double(NSEC_PER_SEC)
        let time  = DispatchTime.now() + Double(Int64(delay)) / Double(NSEC_PER_SEC)
        DispatchQueue.main.asyncAfter(deadline: time, execute: {
            self.audioPlayer?.play()
            self.button.setImage(UIImage(named: "pushButton_maru.png"), for: .normal)
            self.buttonEnabled = true
            self.timerForButtonAction = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(self.measureTime(_:)), userInfo: nil, repeats: true)
            self.timerForButtonAction.fire()
        })
    }
    
    func measureTime(_ sender: Timer) {
        actionTime += 0.01
    }

}

extension ViewController {
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

