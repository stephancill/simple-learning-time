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
    /* instantiated in btnm */
    var correct: Bool = false
    var testActive: Bool = false
    
    var spriteSelfTestHelp: SKSpriteNode = SKSpriteNode(imageNamed: "imageSelfTestHelp") // Set up in button manager (btnm)
    var spriteSelfTestHelp2: SKSpriteNode = SKSpriteNode(imageNamed: "imageSelfTestHelp2") // Set up in button manager (btnm)
    var spriteContainer: SKNode = SKNode()
    var scene: SKScene = SKScene()

    init() {
        
    }
    
    func startTest () {
        // Start the self-test
        testActive = true
        
        // Set clock time to 0:00
        cm.set((CGFloat(12), CGFloat(0)))
        
        let hours = CGFloat(arc4random_uniform(24))
        let minutes = CGFloat(arc4random_uniform(59))
        
        dtm.set((hours, minutes))
        
        scene.addChild(spriteContainer)
        
    }
    
    func endTest () {
        // End the self-test
        testActive = false
        correct = false
        
        spriteContainer.removeFromParent()
    }
    
    func check() {
        // Check answer
        if (cm.time == dtm.time) {
            correct = true
        }
    }
    
}
