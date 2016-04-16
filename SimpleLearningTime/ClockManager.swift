//
//  SpriteManager.swift
//  SimpleLearningTime
//
//  Created by Stephan Cilliers on 2016/03/01.
//  Copyright © 2016 Stephan Cilliers. All rights reserved.
//

import SpriteKit

class ClockManager {
    
    var spriteClockPlaceholder = SKSpriteNode()
    var spriteClockFace = SKSpriteNode(imageNamed: "imageClockBackground")
    var spriteClockMinute = SKSpriteNode(imageNamed: "imageClockMinute")
    var spriteClockHour = SKSpriteNode(imageNamed: "imageClockHour")
    var spriteClockCenter = SKSpriteNode(imageNamed: "imageClockCenter")
    
    var clockElements: [SKSpriteNode]
    var interactiveElements: [String] = ["hour", "minute"]
    
    var hourNodeID: String = "hour"
    var minuteNodeID: String = "minute"
    
    var time = (CGFloat(0), CGFloat(0))
    var center: CGPoint = CGPoint(x: 0, y: 0)
    var distanceFromSceneCenter = CGPoint(x: 0,y: 0)
    
    var twelveHour: Bool = false
    
    // User interaction
    var initialTouch: CGPoint = CGPoint(x: 0, y: 0)
    var startMovement: Bool = false
    
    var currentNodeID: String = ""
    var currentNode: SKNode = SKNode()
    
    var interactivityEnabled: Bool = false
    
    
    init (){
        
        for name in interactiveElements {
            allInteractiveElements.append(name)
        }
        
        //Render order
        clockElements = [
            spriteClockPlaceholder,
            spriteClockFace,
            spriteClockMinute,
            spriteClockHour,
            spriteClockCenter
        ]
        
        spriteClockHour.name = "hour"
        spriteClockMinute.name = "minute"
        
    }
    
    
    func initElements (frameSize: CGSize, scalar:Float, scene:SKScene, time: (CGFloat,CGFloat)=(CGFloat(0),CGFloat(0))) {
        
        let mid = CGPoint(
            x: frameSize.width * 0.5,
            y: frameSize.height * 0.5
        )
        
        distanceFromSceneCenter = CGPoint(
            x: frameSize.width / 8,
            y: 0
        )
        
        center = CGPoint(
            x: mid.x + distanceFromSceneCenter.x,
            y: mid.y + distanceFromSceneCenter.y
        )
        
        var layer = 0
        for element in clockElements {
            
            element.position = center
            element.size = CGSize(
                width: element.size.width * CGFloat(scalar),
                height: element.size.height * CGFloat(scalar)
            )
            element.zPosition = CGFloat(layer)
            
            scene.addChild(element)
            
            layer += 1
            
            
            
        }
        set(time)
        print("cm initialized")
        
        
    }
    
    /* User Interaction handling */
    
    func touchesMoved (touchLocation: CGPoint) {
        
        math.updateAngles(touchLocation, middle: center, first: initialTouch)
        if (startMovement && interactivityEnabled) {       // Don't act if 1st itearion (1st iteration values reset hand position)
            
            if (currentNodeID == "minute" ) {
                rotate(math.deltaTouchAngle/12, nodeID: hourNodeID)
                bgm.rotate(CGFloat(math.deltaTouchAngle/24))
            }
            else {
                bgm.rotate(CGFloat(math.deltaTouchAngle/2))
            }
            
            // Background colour
            bgm.adjustBackgroundColor()
            
            rotate(math.deltaTouchAngle, nodeID: currentNodeID )
            
            if (!stm.testActive) {
                dtm.set(calculateTime())
            }
        }
        
        startMovement = true
        
    }
    
    func touchesStarted (node: SKNode, touchLocation: CGPoint) {
 
        cm.calculateTime(true)
        
        currentNode = node
        currentNodeID = node.name!
        interactivityEnabled = true
        initialTouch = touchLocation
        
    }
    
    func touchesEnded() {
        
        /* Snapping and time setting */
        cm.snap()
        if (!stm.testActive) {
            dtm.set(cm.time)
        }
        
        /* Reset */
        currentNode = SKNode()
        currentNodeID = ""
        interactivityEnabled = false
        startMovement = false
        
    }
    

    
    /* Utility functions */
    
    func snap () {
        
        var hours = (spriteClockHour.zRotation / CGFloat(math.clockHourIntervalConst)) % 24
        var mins = (spriteClockMinute.zRotation / CGFloat(math.clockMinuteIntervalConst)) % 60
        
        if (hours < 0){ hours = 24 + hours}
        if (mins < 0){ mins = 60 + mins}
        
        mins = round(mins)
        hours = floor(hours)
        
        // Hour position = (hour interval * current hour) + (hour interval/60 * minutes)
        spriteClockHour.zRotation = CGFloat(math.clockHourIntervalConst) * floor(hours) + ((CGFloat(math.clockHourIntervalConst / 60) * mins))

        // Minute position = minute interval * minutes
        spriteClockMinute.zRotation = CGFloat(math.clockMinuteIntervalConst) * round(mins)
        
        // Background's rotation is half of hour's rotation
        bgm.set((hours, mins))
        
        time = calculateTime ()
        
    }
    
    func calculateTime (raw: Bool=false) -> (CGFloat, CGFloat) {
        
        var hours = (spriteClockHour.zRotation / CGFloat(math.clockHourIntervalConst)) % 24
        var mins = (spriteClockMinute.zRotation / CGFloat(math.clockMinuteIntervalConst)) % 60
        
        if (hours - floor(hours) > 0.99999 && hours - floor(hours) < 1) {hours += 1}
        
        if (hours < 0){ hours = 24 + hours}
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
        spriteClockHour.zRotation = CGFloat(math.clockHourIntervalConst * Double(time.0) + ((math.clockHourIntervalConst / 60) * Double(time.1)))
        
        // Minute position = minute interval * minutes
        spriteClockMinute.zRotation = CGFloat(math.clockMinuteIntervalConst * Double(time.1))
        
        // Background rotation and color
        bgm.set(time)
 
    }
    
    func rotate (delta: Double, nodeID: String) {
        
        if (nodeID == "minute") {
            spriteClockMinute.zRotation += CGFloat(delta)
        }
        
        if (nodeID == "hour") {
            spriteClockHour.zRotation += CGFloat(delta)
        }
        
    }
    
    
}



