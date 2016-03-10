//
//  GameScene.swift
//  SimpleLearningTime
//
//  Created by Stephan Cilliers on 2016/02/11.
//  Copyright (c) 2016 Stephan Cilliers. All rights reserved.
//
import SpriteKit

let spriteMgr: SpriteManager = SpriteManager()
let math: mf = mf()

class GameScene: SKScene {
    let clockIntervalRadianConst: Double = -360/(180/math.pi)/12/5
    
    var middle: CGPoint = CGPoint(x: 0, y: 0)
    var first: CGPoint = CGPoint(x: CGFloat(0.0), y: CGFloat(0.0))
    var notit1: Bool = true     // Prevents clock reset
    
    var currentTouchAngle: Double = 0
    var lastTouchAngle: Double = 0
    var deltaTouchAngle: Double = 0
    
    var currentNodeID: Int = 0
    var currentNode: SKNode = SKNode()
    var interactivityEnabled: Bool = false
    
    var distanceRotated: Double = 0
    var tmpTotalDistance: Double = 0
    var totalDistanceRotatedHours: Double = 0
    var totalDistanceRotatedMinutes: Double = 0
    var rotate: SKAction = SKAction()
    
    
    override func didMoveToView(view: SKView) {
        
        
        /* Setup your scene here */
        self.name = "scene"
        middle = CGPoint(x: size.width * 0.5, y: size.height * 0.5)
        spriteMgr.initElements(middle, scalar: 0.4, scene: self)
        print(middle)
        for child in self.children {
        
            print(child.name)
            
        }
    
    
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        
        if (interactivityEnabled) {
            
            for touch in touches {
                
                currentTouchAngle = math.angleBetween(middle, P2: first , P3: touch.locationInView(self.view))
                deltaTouchAngle = currentTouchAngle-lastTouchAngle
                print(deltaTouchAngle/abs(deltaTouchAngle))
                if (deltaTouchAngle/abs(deltaTouchAngle) > 0) {
                
                    print(deltaTouchAngle)
                
                }
                lastTouchAngle = currentTouchAngle

                if (notit1) {       // Don't act if 1st itearion (1st iteration values reset hand position)
                    
                    spriteMgr.executeRotation(deltaTouchAngle, nodeID: currentNodeID, scene: self)
                
                }
                
                /* Adjust current time measurements */
                tmpTotalDistance = distanceRotated % (clockIntervalRadianConst*60)
                
                switch (currentNodeID) {
                
                case (2): totalDistanceRotatedMinutes += tmpTotalDistance
                case (3): totalDistanceRotatedHours += tmpTotalDistance
                default: "This shouldn't ever happen..."
                    
                }
                
                distanceRotated += deltaTouchAngle
                distanceRotated = distanceRotated % (clockIntervalRadianConst*60)
                notit1 = true
                
            }
        
        }
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        for touch in touches {
            
            let touchLocation = touch.locationInView(touch.view)
            let node = self.nodeAtPoint(touchLocation)
            
            if (node.name != "scene"){
                if (interactiveElements.contains(Int(node.name!)!)) {
                    
                    currentNode = node
                    currentNodeID = Int(node.name!)!
                    interactivityEnabled = true
                    
                }
                first = touchLocation
            }
            
        }
        
        
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {

        print(distanceRotated)
        var modresult = distanceRotated % clockIntervalRadianConst
        
        if (modresult <= clockIntervalRadianConst/2) {modresult = -modresult}   // Determine adjust direction
        
        spriteMgr.executeRotation((modresult), nodeID: currentNodeID, scene: self)
        tmpTotalDistance += modresult
        
        switch (currentNodeID) {
            
        case (2): totalDistanceRotatedMinutes += tmpTotalDistance
        case (3): totalDistanceRotatedHours += tmpTotalDistance
        default: "This shouldn't ever happen..."
            
        }
        
        /*Reset*/
        currentNode = SKNode()
        currentNodeID = 0     // Turns out -1 is not a good placeholder
        interactivityEnabled = false
        distanceRotated = 0
        tmpTotalDistance = 0
        notit1 = false
        
    
    }
    
    
}
// Fix distanceRotated 
// Record dist at touch start, record dist at touch end mod angle between start and end by const then calculate difference between distanceRotated and compensate
