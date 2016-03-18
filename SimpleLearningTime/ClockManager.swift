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
    var spriteClockMinuteDirector = SKSpriteNode()
    var spriteClockHourDirector = SKSpriteNode()
    var spriteClockBG = SKSpriteNode(imageNamed: "imageClockBackground")
    var spriteClockMinute = SKSpriteNode(imageNamed: "imageClockMinute")
    var spriteClockHour = SKSpriteNode(imageNamed: "imageClockHour")
    var spriteClockCenter = SKSpriteNode(imageNamed: "imageClockCenter")
    
    var spriteSceneBackground = SKSpriteNode()
    var spriteDigitalDigits = SKSpriteNode()
    
    var clockElements: [SKSpriteNode]
    var hourNodeID: Int = 0
    var minuteNodeID: Int = 0
    var time = (CGFloat(0), CGFloat(0))

    
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
    
    
    func initElements (mid:CGPoint, scalar:Float, scene:SKScene, time: (CGFloat, CGFloat)=(CGFloat(0), CGFloat(0)) ) -> Void{

        var layer = 0
        for element in clockElements {
            
            switch (element.name){
            case ("hour"?): interactiveElements.append(layer); hourNodeID = layer
            case ("minute"?): interactiveElements.append(layer); minuteNodeID = layer
            default: break
            }
            
            element.name = String(layer)
            element.position = mid
            element.size = CGSize(width: element.size.width * CGFloat(scalar), height: element.size.height * CGFloat(scalar))
            element.zPosition = CGFloat(layer)
            
            scene.addChild(element)
            
            layer++
            
        }
        set(time)
        print("cm initialized")
    }
    
    func rotate (delta: Double, nodeID: Int) {
    
        clockElements[nodeID].zRotation += CGFloat(delta)
        
    }

    
    func snap () {

        var hours = (clockElements[hourNodeID].zRotation / CGFloat(math.clockHourIntervalConst)) % 24
        var mins = (clockElements[minuteNodeID].zRotation / CGFloat(math.clockMinuteIntervalConst)) % 60
        
        if (hours < 0){ hours = 24 + hours}
        if (mins < 0){ mins = 60 + mins}
        
        mins = round(mins)
        hours = floor(hours)
        
        // Hour position = (hour interval * current hour) + (hour interval/60 * minutes)
        clockElements[hourNodeID].zRotation = CGFloat(math.clockHourIntervalConst) * floor(hours) + ((CGFloat(math.clockHourIntervalConst / 60) * mins))
        
        // Minute position = minute interval * minutes
        clockElements[minuteNodeID].zRotation = CGFloat(math.clockMinuteIntervalConst) * round(mins)
        
        time = timecalc()
        print(time)
        
    }
    
    func timecalc (raw: Bool=false) -> (CGFloat, CGFloat) {
        
        var hours = (clockElements[hourNodeID].zRotation / CGFloat(math.clockHourIntervalConst)) % 24
        var mins = (clockElements[minuteNodeID].zRotation / CGFloat(math.clockMinuteIntervalConst)) % 60
        
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
        
        // Hour position = (hour interval * current hour) + (hour interval/60 * minutes)
        clockElements[hourNodeID].zRotation = CGFloat(math.clockHourIntervalConst * Double(time.0) + ((math.clockHourIntervalConst / 60) * Double(time.1)))
        
        // Minute position = minute interval * minutes
        clockElements[minuteNodeID].zRotation = CGFloat(math.clockMinuteIntervalConst * Double(time.1))
        self.time = time
        
        
    }
    
}



