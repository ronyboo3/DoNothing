//
//  GATrackingManager.swift
//  DoNothing
//
//  Created by 棚瀬 隆太 on 2017/01/27.
//  Copyright © 2017年 棚瀬 隆太. All rights reserved.
//

import Foundation

class GATrackingManager {
    
    class func sendScreenTracking(screenName: String) {
        let tracker = GAI.sharedInstance().defaultTracker
        tracker?.set(kGAIScreenName, value: screenName)
        tracker?.send(GAIDictionaryBuilder.createScreenView().build() as [NSObject: AnyObject])
        tracker?.set(kGAIScreenName, value: nil)
    }
    
}
