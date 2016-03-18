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
    
    /*---*/
    var tmpSpriteBackground = SKSpriteNode(color: UIColor.whiteColor(), size: UIScreen.mainScreen().bounds.size)
    /*---*/
    
    var middle: CGPoint = CGPoint(x: 0, y: 0)
    var initialTouch: CGPoint = CGPoint(x: 0, y: 0)
    
    var startMovement: Bool = false
    
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
        
        /*---*/
        tmpSpriteBackground.position = middle
        tmpSpriteBackground.zPosition = -1
        self.addChild(tmpSpriteBackground)
        /*---*/
        
        cm.initElements(size, scalar: 0.55, scene: self, time: math.currentDeviceTime())
        dtm.initElements(size, time: cm.time, scalar: 0.5, scene: self)
        
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        if (interactivityEnabled) {
            
            for touch in touches {
                
                math.updateAngles(touch, middle: cm.center, first: initialTouch)
                if (startMovement) {       // Don't act if 1st itearion (1st iteration values reset hand position)
                    
                    if (currentNodeID == 2 ) { cm.rotate(math.deltaTouchAngle/12, nodeID: 3) }       // 3 is nodeID of the hour pointer
                    cm.rotate(math.deltaTouchAngle, nodeID: currentNodeID  )
                    dtm.set(cm.timecalc())
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
            
            //  Set the node to the first interactive node
            for n in nodes {
                print("\(n.name)")
                if (n.name != nil) {
                    if (interactiveElements.contains(Int(n.name!)!)) {
                        node = n
                        break
                    }
                }
            }
            
            if (node.name != nil){
                
                cm.timecalc(true)
    
                currentNode = node
                currentNodeID = Int(node.name!)!
                interactivityEnabled = true
                initialTouch = touchLocation
            }
            
        }
        
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        /* Snapping and time setting */
        if (interactivityEnabled) {
            
            cm.snap()
            dtm.set(cm.time)
        }
        
        /* Reset */
        currentNode = SKNode()
        currentNodeID = 0     // Turns out -1 is not a good placeholder
        interactivityEnabled = false
        startMovement = false
        
    }
    

}
