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
    
    func rotateElement (delta: Double, nodeID: Int) {
    
        clockElements[nodeID].zRotation += CGFloat(delta)
        
    }

    
    func snap () {
    
        var hours = clockElements[3].zRotation / CGFloat(math.clockHourIntervalConst) % 12
        var mins = floor(clockElements[2].zRotation / CGFloat(math.clockMinuteIntervalConst)) % 60
        
        if (hours < 0){ hours = 12 + hours}     // If number of hours counter is negative, subtract it from 12.
        if (mins < 0){ mins = 60 + mins}        // If number of minutes counter is negative, subtract it from 12.
        
        // Hour position = (hour interval * current hour) + (hour interval/60 * minutes)
        clockElements[3].zRotation = CGFloat(math.clockHourIntervalConst) * floor(hours) + ((CGFloat(math.clockHourIntervalConst / 60) * mins))
        
        // Minute position = minute interval * minutes
        clockElements[2].zRotation = CGFloat(math.clockMinuteIntervalConst) * round(mins)
        
        hours = floor(hours)
        mins = round(mins)
        
        time = (hours, mins)
        
    }

    
}



class DigitalTimeManager {

//    var spritesheet: SKTexture = SKTexture(imageNamed: "imageDigitalDigits")
    var spritesheetfull = SKSpriteNode(imageNamed: "imageDigitalDigits")
    var displayTime: [SKSpriteNode] = []
    var fourdigitTime = []
    
    let digitHeight = 100
    let digitWidth = 56
    
    func initElements (time:(CGFloat, CGFloat), mid:CGPoint, scalar:Float, scene:SKScene) {
    
//        var test = SKSpriteNode(texture: SKTexture(rect: CGRect(x: digitWidth*0, y: 0, width: digitWidth, height: digitHeight), inTexture: spritesheet))
        let itertime = stringsToList(String(time.0), m: String(time.1))
        print("Initialising dtm")
        
        
        var indexCount = 0
        for digit in itertime {
//            var element = displayTime[indexCount]
//            element = SKSpriteNode(texture: SKTexture(rect: CGRect(x: digitWidth*Int(digit)!, y: 0, width: digitWidth, height: digitHeight), inTexture: spritesheet))
//            element.position = CGPoint(x: mid.x-CGFloat((digitWidth*2)+digitWidth*indexCount), y: mid.y+CGFloat(digitHeight*2))
//            
//            displayTime[indexCount] = element
//            scene.addChild(displayTime[indexCount])
            let n = Double(digit)!/10
            let spritesheet = SKSpriteNode(texture: SKTexture(rect: CGRect(x: n, y: 0.0, width: 0.1, height: 1.0), inTexture: spritesheetfull.texture!))
//            print("\(spritesheetfull.texture!.size().height), \(spritesheetfull.texture!.size().width)")
            spritesheet.position = CGPoint(x: 22.24 * Double(indexCount),y: 0)
            spritesheet.size = CGSize(width: spritesheet.size.width * CGFloat(scalar), height: spritesheet.size.height * CGFloat(scalar))
            spritesheet.anchorPoint = CGPoint(x: 0, y: 0)
            
            displayTime.append(spritesheet)
            scene.addChild(displayTime[indexCount])
            indexCount++

        }
    }
    
    func set (time:(CGFloat, CGFloat), scene: SKScene, scalar: Double) {
    
        var indexCount = 0
        let itertime = stringsToList(String(time.0/100), m: String(time.1/100))
        print(itertime)
        for digit in itertime {
            displayTime[indexCount].removeFromParent()
            let n = Double(digit)!/10
            let spritesheet = SKSpriteNode(texture: SKTexture(rect: CGRect(x: n, y: 0.0, width: 0.1, height: 1.0), inTexture: spritesheetfull.texture!))
            spritesheet.position = CGPoint(x: 22.24 * Double(indexCount),y: 0)
            spritesheet.size = CGSize(width: spritesheet.size.width * CGFloat(scalar), height: spritesheet.size.height * CGFloat(scalar))
            spritesheet.anchorPoint = CGPoint(x: 0, y: 0)
            
            displayTime[indexCount] = spritesheet
            scene.addChild(displayTime[indexCount])
            indexCount++
            
        }
    
    }
    
    
    func stringsToList (h: String, m: String) -> [String] {
        var itertime: [String] = []
        
        var currentHour = h
        var currentMin = m
        
        var index = currentHour.startIndex.advancedBy(2)
        
        index = currentHour.startIndex.advancedBy(2)
        currentHour = currentHour.substringFromIndex(index)
        if (currentHour.characters.count <= 1) {currentHour = "\(0)\(currentHour)"}
        for char in currentHour.characters {
            
            itertime.append(String(char))
        }
        
        index = currentMin.startIndex.advancedBy(2)
        currentMin = currentMin.substringFromIndex(index)
        if (currentMin.characters.count <= 1) {currentMin = "\(0)\(currentMin)"}
        for char in currentMin.characters {
            
            itertime.append(String(char))
        }
        
        return itertime
    }
    
    
    
    

}