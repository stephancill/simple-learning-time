//
//  SelfTestManager.swift
//  SimpleLearningTime
//
//  Created by Stephan Cilliers on 2016/04/07.
//  Copyright © 2016 Stephan Cilliers. All rights reserved.
//

import Foundation
import SpriteKit

class SelfTestManager {

    var correct: Bool = false
    var testActive: Bool = false
    var lastTime: (CGFloat, CGFloat) = (0, 0)
    init() {
        
    }
    
    func startTest () {
        // Start the self-test
        testActive = true
        
        // Store current time
        lastTime = cm.time
        
        // Set clock time to 0:00
        cm.set((CGFloat(12), CGFloat(0)))
        
        let hours = CGFloat(arc4random_uniform(24))
        let minutes = CGFloat(arc4random_uniform(13))
        
        dtm.set((hours, minutes))
    }
    
    func endTest () {
        // End the self-test
        testActive = false
//        cm.set(lastTime)
//        dtm.set(lastTime)
    }
    
    func check() {
        // Check the answer
        
        if (cm.time == dtm.time) {
            correct = true
        }
    }
    
}
