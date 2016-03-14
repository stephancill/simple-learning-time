//
//  GameScene.swift
//  SimpleLearningTime
//
//  Created by Stephan Cilliers on 2016/02/11.
//  Copyright (c) 2016 Stephan Cilliers. All rights reserved.
//
import SpriteKit

let cm: ClockManager = ClockManager()
let dtm: DigitalTimeManager = DigitalTimeManager()
let math: mf = mf()

class GameScene: SKScene {
    
    var middle: CGPoint = CGPoint(x: 0, y: 0)
    var first: CGPoint = CGPoint(x: CGFloat(0.0), y: CGFloat(0.0))

    var startMovement: Bool = false
    
    var currentTouchAngle: Double = 0
    var lastTouchAngle: Double = 0
    var deltaTouchAngle: Double = 0
    var lastDeltaTouchAngle: Double = 0
    
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
        cm.initElements(middle, scalar: 0.4, scene: self)
        print(middle)
        dtm.initElements(cm.time, mid: middle, scalar: 0.4, scene: self)
        
        
    
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        if (interactivityEnabled) {
            
            for touch in touches {
                
                currentTouchAngle = math.angleBetween(middle, P2: first , P3: touch.locationInView(self.view))
                deltaTouchAngle = currentTouchAngle-lastTouchAngle
                lastTouchAngle = currentTouchAngle
                
                if (abs(deltaTouchAngle-lastDeltaTouchAngle) > 0.9) {deltaTouchAngle = -0.0001 * (deltaTouchAngle/deltaTouchAngle)}     // Prevent jumping
                lastDeltaTouchAngle = deltaTouchAngle
                
                print(deltaTouchAngle)
                if (startMovement) {       // Don't act if 1st itearion (1st iteration values reset hand position)
                    
                    cm.rotate(deltaTouchAngle, nodeID: currentNodeID)
                    
                    if (currentNodeID == 2 ) {
                        
                        cm.rotate(deltaTouchAngle/12, nodeID: 3)
                    }
                    
                }
                
                startMovement = true
            }
            
        }
        
    
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        print("Touches began")
        
        for touch in touches {
            
            let touchLocation = touch.locationInView(touch.view)
            print(touchLocation)
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
        
        
        /* Snapping and time setting */
        if (interactivityEnabled) {
            
            cm.snap()
            dtm.set(cm.time, scene: self, scalar: 0.4)
        
        }
        
        /* Reset */
        currentNode = SKNode()
        currentNodeID = 0     // Turns out -1 is not a good placeholder
        interactivityEnabled = false
        startMovement = false
        
    
    }
    

}
