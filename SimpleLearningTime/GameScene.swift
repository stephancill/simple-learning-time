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
//    let clockIntervalRadianConst: Double = -360/(180/math.pi)/12/5;
    var middle: CGPoint = CGPoint(x: 0, y: 0)
    var first: CGPoint = CGPoint(x: CGFloat(0.0), y: CGFloat(0.0))

    var startMovement: Bool = false
    
    var currentTouchAngle: Double = 0
    var lastTouchAngle: Double = 0
    var deltaTouchAngle: Double = 0
    
    var currentNodeID: Int = 0
    var currentNode: SKNode = SKNode()
    var interactivityEnabled: Bool = false
    
    var rotate: SKAction = SKAction()
    
    var currentTimeHour: CGFloat = 0
    var currentTimeMin: CGFloat = 0
    
    override func didMoveToView(view: SKView) {
        
        
        /* Setup your scene here */
        self.name = "scene"

        middle = CGPoint(x: size.width * 0.5, y: size.height * 0.5)
        spriteMgr.initElements(middle, scalar: 0.4, scene: self)
        print(middle)
        
    
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        
        if (interactivityEnabled) {
            
            for touch in touches {
                
                currentTouchAngle = math.angleBetween(middle, P2: first , P3: touch.locationInView(self.view))
                deltaTouchAngle = currentTouchAngle-lastTouchAngle
                lastTouchAngle = currentTouchAngle
                
                if (startMovement) {       // Don't act if 1st itearion (1st iteration values reset hand position)
                    
                    spriteMgr.rotateElement(deltaTouchAngle, nodeID: currentNodeID)
                    
                    
                }
                
                startMovement = true
            }
            
        }
        
    
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        
        print("Touches began")
        
        for touch in touches {
            
            let touchLocation = touch.locationInView(touch.view)
            var node: SKNode = SKNode()
            let nodes = self.nodesAtPoint(touchLocation)
            
            for n in nodes {
                print("\(n.name)")
                
                if (interactiveElements.contains(Int(n.name!)!)) {
                    node = n
                    break
                }
            
            }
            
            if (node.name != nil){

                    currentNode = node
                    currentNodeID = Int(node.name!)!
                    interactivityEnabled = true
                    first = touchLocation

            }
            
        }
        
        
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        
        /*Snapping*/
        var hours = spriteMgr.clockElements[3].zRotation / CGFloat(math.clockHourIntervalConst)
        var mins = spriteMgr.clockElements[2].zRotation / CGFloat(math.clockMinuteIntervalConst)
        
        print("MINS: Rounded: \(round(mins)) - Raw: \(mins) = Diff: \(round(mins)-mins)")
        print("HOURS: Rounded: \(round(hours)) - Raw: \(hours) = Diff: \(round(hours)-hours)")
        
        spriteMgr.clockElements[3].zRotation = CGFloat(math.clockHourIntervalConst) * floor(hours) + CGFloat(math.clockHourIntervalConst / 60) * mins
        spriteMgr.clockElements[2].zRotation = CGFloat(math.clockMinuteIntervalConst) * round(mins)
        
        hours = spriteMgr.clockElements[1].zRotation / CGFloat(math.clockHourIntervalConst)
        mins = spriteMgr.clockElements[2].zRotation / CGFloat(math.clockMinuteIntervalConst)
        
        print("Mins \(Int(mins))")
        print("Hours: \(Int(hours))")
        
        /*Reset*/
        currentNode = SKNode()
        currentNodeID = 0     // Turns out -1 is not a good placeholder
        interactivityEnabled = false
        startMovement = false
        
    
    }
    

}
//
// Add hour and minute hand as children of center points with features surrounding the clock that can rotate as seen here http://stackoverflow.com/questions/19045067/is-it-possible-to-rotate-a-node-around-an-arbitrary-point-in-spritekit
// SCRAP EVERYTHING, USE element.ZROTATION
// Fix distanceRotated 
// Record dist at touch start, record dist at touch end mod angle between start and end by const then calculate difference between distanceRotated and compensate
