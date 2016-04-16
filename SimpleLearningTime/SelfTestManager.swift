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
        dtm.set((CGFloat(12), CGFloat(0)))
        
    }
    
    func endTest () {
        // End the self-test
        testActive = false
        cm.set(lastTime)
    }
    
    func check() {
        // Check the answer
        correct = !correct
    }
    
}
