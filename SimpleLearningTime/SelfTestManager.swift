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
    var testActive: Bool = true
    
    init() {
        
    }
    
    func startTest () {
        // Start the self-test
        testActive = true
        
    }
    
    func endTest () {
        // End the self-test
        correct = false
        testActive = false
        
    }
    
    func check() {
        correct = !correct
    }
    
}
