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
 
        print("Setup: [1/2]Sprite manager initialised")
        
    }
    
    
    func initElements (mid:CGPoint, scalar:Float, scene:SKScene, hourRotDegrees:Double = 0, minRotDegrees:Double = 0) -> Void{

        var layer = 0
        var interactiveLayer = 0
        for element in clockElements {
            
            switch (element.name){
            case ("hour"?): interactiveElements.append(layer)
            case ("minute"?): interactiveElements.append(layer)
            default: break
            }
            
            element.name = String(layer)
            element.position = mid
            element.size = CGSize(width: element.size.width * CGFloat(scalar), height: element.size.height * CGFloat(scalar))
            element.zPosition = CGFloat(layer)
            
            print(element.name)
            
            if (interactiveElements.contains(layer)){
                // Interactive
                switch (interactiveLayer){
                case (0): element.zRotation = CGFloat(minRotDegrees * math.pi / 180)
                case (1): element.zRotation = CGFloat(hourRotDegrees * math.pi / 180)
                default: continue
                }
                interactiveLayer++
            } else {
                
            }
            scene.addChild(element)
            
            layer++
            
        }
        print("Setup: [2/2]Sprites initialised")
        
    }
    
    func rotate (delta: Double, nodeID: Int) {
    
        clockElements[nodeID].zRotation += CGFloat(delta)
        
    }

    
    func snap () {

        var hours = (clockElements[3].zRotation / CGFloat(math.clockHourIntervalConst)) % 24
        var mins = (clockElements[2].zRotation / CGFloat(math.clockMinuteIntervalConst)) % 60
        
        if (hours < 0){ hours = 24 + hours}     // If number of hours counter is negative, subtract it from 12.
        if (mins < 0){ mins = 60 + mins}        // If number of minutes counter is negative, subtract it from 12.
        
        mins = round(mins)
        hours = floor(hours)
        
        // Hour position = (hour interval * current hour) + (hour interval/60 * minutes)
        clockElements[3].zRotation = CGFloat(math.clockHourIntervalConst) * floor(hours) + ((CGFloat(math.clockHourIntervalConst / 60) * mins))
        
        // Minute position = minute interval * minutes
        clockElements[2].zRotation = CGFloat(math.clockMinuteIntervalConst) * round(mins)
        
        time = timecalc()
        print(time)
        
    }
    
    func timecalc (raw: Bool=false) -> (CGFloat, CGFloat) {
        
        var hours = (clockElements[3].zRotation / CGFloat(math.clockHourIntervalConst)) % 24
        var mins = (clockElements[2].zRotation / CGFloat(math.clockMinuteIntervalConst)) % 60
        
        if (hours - floor(hours) > 0.99999 && hours - floor(hours) < 1) {hours += 1}    // Sometimes division don't go very well
        
        if (hours < 0){ hours = 24 + hours}     // If number of hours counter is negative, subtract it from 12.
        if (mins < 0){ mins = 60 + mins}        // If number of minutes counter is negative, subtract it from 12.

        if (!raw) {
            hours = floor(floor(hours) + (round(mins)/60)) % 24
            mins = round(mins) % 60
        }
        
        
        return (hours, mins)
        
    }
    
}



