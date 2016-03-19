//
//  SpriteManager.swift
//  SimpleLearningTime
//
//  Created by Stephan Cilliers on 2016/03/01.
//  Copyright © 2016 Stephan Cilliers. All rights reserved.
//

import SpriteKit

var interactiveElements: [Int] = []

class ClockManager {
    
    var spriteClockPlaceholder = SKSpriteNode()
    var spriteClockBG = SKSpriteNode(imageNamed: "imageClockBackground")
    var spriteClockMinute = SKSpriteNode(imageNamed: "imageClockMinute")
    var spriteClockHour = SKSpriteNode(imageNamed: "imageClockHour")
    var spriteClockCenter = SKSpriteNode(imageNamed: "imageClockCenter")
    
    var clockElements: [SKSpriteNode]
    
    var hourNodeID: Int = 0
    var minuteNodeID: Int = 0
    
    var time = (CGFloat(0), CGFloat(0))
    var center: CGPoint = CGPoint(x: 0, y: 0)
    var distanceFromSceneCenter = CGPoint(x: 0,y: 0)
    
    var hourMod: CGFloat = 24
    
    // User interaction
    var initialTouch: CGPoint = CGPoint(x: 0, y: 0)
    var startMovement: Bool = false
    
    var currentNodeID: Int = 0
    var currentNode: SKNode = SKNode()
    
    var interactivityEnabled: Bool = false
    
    
    init (){
        
        //Render order
        clockElements = [
            spriteClockPlaceholder,
            spriteClockBG,
            spriteClockMinute,
            spriteClockHour,
            spriteClockCenter
        ]
        
        spriteClockHour.name = "hour"
        spriteClockMinute.name = "minute"
        
    }
    
    
    func initElements (frameSize: CGSize, scalar:Float, scene:SKScene, time: (CGFloat, CGFloat)=(CGFloat(0), CGFloat(0)) ) {
        
        let mid = CGPoint(x: frameSize.width * 0.5, y: frameSize.height * 0.5)
        distanceFromSceneCenter = CGPoint(x: frameSize.width / 8, y: 0)
        center = CGPoint(x: mid.x + distanceFromSceneCenter.x, y: mid.y + distanceFromSceneCenter.y)
        
        var layer = 0
        for element in clockElements {
            
            switch (element.name){
            case ("hour"?): interactiveElements.append(layer); hourNodeID = layer;
            case ("minute"?): interactiveElements.append(layer); minuteNodeID = layer
            default: break
            }
            
            element.name = String(layer)
            element.position = center
            element.size = CGSize(width: element.size.width * CGFloat(scalar), height: element.size.height * CGFloat(scalar))
            element.zPosition = CGFloat(layer)
            
            scene.addChild(element)
            
            layer++
            
            
            
        }
        set(time)
        print("cm initialized")
        
        
    }
    
    /* Main functions */
    
    func touchesMoved (touches: Set<UITouch>){
        
        let touch = touches.first
        
        math.updateAngles(touch!, middle: center, first: initialTouch)
        if (startMovement && interactivityEnabled) {       // Don't act if 1st itearion (1st iteration values reset hand position)
            
            if (currentNodeID == minuteNodeID ) {
                rotate(math.deltaTouchAngle/12, nodeID: hourNodeID)
                bgm.rotate(CGFloat(math.deltaTouchAngle/24))
            }
            else {
                bgm.rotate(CGFloat(math.deltaTouchAngle/2))
            }
            
            // Background colour
            bgm.adjustBackgroundColor()
            
            rotate(math.deltaTouchAngle, nodeID: currentNodeID )
            dtm.set(cm.calculateTime())
        }
        
        startMovement = true
    }
    
    func touchesBegan (touches: Set<UITouch>, scene: SKScene) {
        
        let touch = touches.first
        let touchLocation = touch!.locationInView(scene.view)
        var node: SKNode = SKNode()
        let nodes = scene.nodesAtPoint(touchLocation)
        //  Set the node to the first interactive node
        for n in nodes {
            if (n.name != nil) {
                if (interactiveElements.contains(Int(n.name!)!)) {
                    node = n
                    break
                }
            }
        }
        
        if (node.name != nil && interactiveElements.contains(Int(node.name!)!)){
            
            cm.calculateTime(true)
            
            currentNode = node
            currentNodeID = Int(node.name!)!
            interactivityEnabled = true
            initialTouch = touchLocation
        }
        
    }
    
    func touchesEnded(touches: Set<UITouch>) {
        
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
    

    
    /*Utility functions*/
    
    func snap () {

        var hours = (clockElements[hourNodeID].zRotation / CGFloat(math.clockHourIntervalConst)) % hourMod
        var mins = (clockElements[minuteNodeID].zRotation / CGFloat(math.clockMinuteIntervalConst)) % 60
        
        if (hours < 0){ hours = hourMod + hours}
        if (mins < 0){ mins = 60 + mins}
        
        mins = round(mins)
        hours = floor(hours)
        
        // Hour position = (hour interval * current hour) + (hour interval/60 * minutes)
        clockElements[hourNodeID].zRotation = CGFloat(math.clockHourIntervalConst) * floor(hours) + ((CGFloat(math.clockHourIntervalConst / 60) * mins))
        
        // Minute position = minute interval * minutes
        clockElements[minuteNodeID].zRotation = CGFloat(math.clockMinuteIntervalConst) * round(mins)
        
        // Background's rotation is half of hour's rotation
        bgm.set((hours, mins))
        
        time = calculateTime ()
        
    }
    
    func calculateTime (raw: Bool=false) -> (CGFloat, CGFloat) {
        
        var hours = (clockElements[hourNodeID].zRotation / CGFloat(math.clockHourIntervalConst)) % hourMod
        var mins = (clockElements[minuteNodeID].zRotation / CGFloat(math.clockMinuteIntervalConst)) % 60
        
        if (hours - floor(hours) > 0.99999 && hours - floor(hours) < 1) {hours += 1}
        
        if (hours < 0){ hours = hourMod + hours}
        if (mins < 0){ mins = 60 + mins}

        if (!raw) {
            hours = floor(floor(hours) + (round(mins)/60)) % 24
            mins = round(mins) % 60
        }
        
        return (hours, mins)
        
    }
    
    func set (time: (CGFloat, CGFloat)) {
        
        self.time = time
        
        // Hour position = (hour interval * current hour) + (hour interval/60 * minutes)
        clockElements[hourNodeID].zRotation = CGFloat(math.clockHourIntervalConst * Double(time.0) + ((math.clockHourIntervalConst / 60) * Double(time.1)))
        
        // Minute position = minute interval * minutes
        clockElements[minuteNodeID].zRotation = CGFloat(math.clockMinuteIntervalConst * Double(time.1))
        
        // Background rotation and color
        bgm.set(time)
 
    }
    
    func rotate (delta: Double, nodeID: Int) {
        
        clockElements[nodeID].zRotation += CGFloat(delta)
        
    }
    
    
}



