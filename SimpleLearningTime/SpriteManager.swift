//
//  SpriteManager.swift
//  SimpleLearningTime
//
//  Created by Stephan Cilliers on 2016/03/01.
//  Copyright © 2016 Stephan Cilliers. All rights reserved.
//

import SpriteKit

var interactiveElements: [Int] = [2,3]

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
    
    var clockElements: [SKSpriteNode]   // Allows for convenient iteration
    
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
        
        
        
        print("Setup: [1/2]Sprite manager initialised")
        
    }
    
    func initElements (mid:CGPoint, scalar:Float, scene:SKScene, hourRotDegrees:Double = 0, minRotDegrees:Double = 0) -> Void{

        
        var layer = 0
        var interactiveLayer = 0
        for element in clockElements {
            
            element.name = String(layer)
            element.position = mid
            element.size = CGSize(width: element.size.width * CGFloat(scalar), height: element.size.height * CGFloat(scalar))
            element.zPosition = CGFloat(layer)  // Order elements for visual consistency
            
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
    
    func rotateElement (delta: Double, nodeID: Int) {
    
        clockElements[nodeID].zRotation += CGFloat(delta)
        
    }
    
    func adjustElement (nodeID: Int) {
    
        let constant = CGFloat(-360/(180/math.pi)/12/5)
        let rotation = clockElements[nodeID].zRotation
        
        if (abs(rotation%constant) < abs(constant/2)) {
            clockElements[nodeID].zRotation += clockElements[nodeID].zRotation % (constant * -1)
        } else {
            clockElements[nodeID].zRotation -= clockElements[nodeID].zRotation % (constant * -1)
        }
    
    }
    
    func snap () {
    
        var hours = clockElements[3].zRotation / CGFloat(math.clockHourIntervalConst) % 12
        var mins = floor(clockElements[2].zRotation / CGFloat(math.clockMinuteIntervalConst)) % 60
        
        if (hours < 0){ hours = 12 + hours}
        if (mins < 0){ mins = 60 + mins}
        
        print("Hours: \(hours)")
        print("Mins: \(mins)")
        //            print("MINS: Rounded: \(round(mins)%60) - Raw: \(mins%60) = Diff: \(round(mins)-mins)")
        //            print("HOURS: Rounded: \(round(hours)%24) - Raw: \(hours%24) = Diff: \(round(hours)-hours)")
        
        clockElements[3].zRotation = CGFloat(CGFloat(math.clockHourIntervalConst)) * floor(hours) + ((CGFloat(math.clockHourIntervalConst / 60) * mins))
        clockElements[2].zRotation = CGFloat(math.clockMinuteIntervalConst) * round(mins)
        
        hours = floor(hours)
        mins = round(mins)
        
        time = (hours, mins)
        
    }

    
}