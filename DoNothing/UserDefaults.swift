//
//  UserDefaults.swift
//  DoNothing
//
//  Created by 棚瀬 隆太 on 2017/03/03.
//  Copyright © 2017年 棚瀬 隆太. All rights reserved.
//

import Foundation

final class UserDefaults {
    
    static let sharedInstance = UserDefaults()
    let userDefaults = Foundation.UserDefaults.standard
    
    func saveIsSetAlarm(isOn: Bool) {
        userDefaults.set(isOn, forKey: "isSetAlarm")
        userDefaults.synchronize()
    }
    func fetchIsSetAlarm() -> Bool? {
        return userDefaults.object(forKey: "isSetAlarm") as? Bool
    }
    func removeIsSetAlarm() {
        userDefaults.removeObject(forKey: "isSetAlarm")
        userDefaults.synchronize()

    }
    
    func saveAlarmTime(time: String) {
        userDefaults.set(time, forKey: "alarmTime")
        userDefaults.synchronize()
    }
    func fetchAlarmTime() -> String? {
        return userDefaults.object(forKey: "alarmTime") as? String
    }
    func removeAlarmTime() {
        userDefaults.removeObject(forKey: "alarmTime")
        userDefaults.synchronize()
    }
    
    // 累計タップ数
    func saveTotalTap(count: Int) {
        userDefaults.set(count, forKey: "totalTap")
        userDefaults.synchronize()
    }
    func fetchTotalTap() -> Int? {
        return userDefaults.object(forKey: "totalTap") as? Int
    }
    func removeTotalTap() {
        userDefaults.removeObject(forKey: "totalTap")
        userDefaults.synchronize()
    }

    // ボタンがアクティブになってからまたタップするまでの最速時間
    func saveFastestTapTime(time: CGFloat) {
        userDefaults.set(time, forKey: "fastestTapTime")
        userDefaults.synchronize()
    }
    func fetchFastestTapTime() -> CGFloat? {
        return userDefaults.object(forKey: "fastestTapTime") as? CGFloat
    }
    func removeFastestTapTime() {
        userDefaults.removeObject(forKey: "fastestTapTime")
        userDefaults.synchronize()
    }
    
    // ボタンがアクティブになってからまたタップするまでの最遅時間
    func saveLatestTapTime(time: CGFloat) {
        userDefaults.set(time, forKey: "latestTapTime")
        userDefaults.synchronize()
    }
    func fetchLatestTapTime() -> CGFloat? {
        return userDefaults.object(forKey: "latestTapTime") as? CGFloat
    }
    func removeLatestTapTime() {
        userDefaults.removeObject(forKey: "latestTapTime")
        userDefaults.synchronize()
    }
    
    // 前回プレイしたときのタップ数
    func saveLastTapCount(count: Int) {
        userDefaults.set(count, forKey: "lastTapCount")
        userDefaults.synchronize()
    }
    func fetchLastTapCount() -> Int? {
        return userDefaults.object(forKey: "lastTapCount") as? Int
    }
    func removeLastTapCount() {
        userDefaults.removeObject(forKey: "lastTapCount")
        userDefaults.synchronize()
    }
    
    // 今回のタップ数
    func saveCurrentTap(count: Int) {
        userDefaults.set(count, forKey: "currentTap")
        userDefaults.synchronize()
    }
    func fetchCurrentTap() -> Int? {
        return userDefaults.object(forKey: "currentTap") as? Int
    }
    func removeCurrentTap() {
        userDefaults.removeObject(forKey: "currentTap")
        userDefaults.synchronize()
    }
}
