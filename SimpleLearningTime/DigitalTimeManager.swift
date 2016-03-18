//
//  DigitalTimeManager.swift
//  SimpleLearningTime
//
//  Created by Stephan Cilliers on 2016/03/14.
//  Copyright © 2016 Stephan Cilliers. All rights reserved.
//

import SpriteKit

class DigitalTimeManager {
    
    var spritesheetfull = SKSpriteNode(imageNamed: "imageDigitalDigits")
    var displayTime: [SKSpriteNode] = []
    var displayTimeContainer: SKNode = SKNode()
    
    let digitHeight = 100.0
    let digitWidth = 56.0
    let colconWidth = 12.0
    
    var xpos = CGFloat(0)
    var center = CGPoint(x: 0,y: 0)
    var scalar = Float()
    var scene = SKScene()
    
    func initElements (frameSize: CGSize, time:(CGFloat, CGFloat), scalar:Float, scene:SKScene) {
        
        center = CGPoint(x: frameSize.width / 32 * 2, y: frameSize.height / 32 * 2)
        
        self.scalar = scalar
        self.scene = scene
        
        let itertime = stringsToList(String(time.0/100), m: String(time.1/100))
        print("Initialising dtm")
        
        displayTimeContainer.position = CGPoint(x: xpos + CGFloat(digitWidth) * 2 * CGFloat(scalar), y: center.y)
        
        var indexCount = 0
        for digit in itertime {
            
            xpos = center.x - CGFloat(2 * digitWidth * Double(scalar))
            
            let digitSprite = SKSpriteNode(texture: SKTexture(rect: CGRect(x: Double(digit)!/10, y: 0.0, width: 0.1, height: 1.0), inTexture: spritesheetfull.texture!))
            
            digitSprite.position = CGPoint(x: xpos + CGFloat(digitWidth) * CGFloat(scalar) * CGFloat(indexCount), y: center.y)
            digitSprite.size = CGSize(width: digitSprite.size.width * CGFloat(scalar), height: digitSprite.size.height * CGFloat(scalar))
            digitSprite.anchorPoint = CGPoint(x: 0, y: 0)
            digitSprite.zPosition = 10
            
            displayTime.append(digitSprite)
            displayTimeContainer.addChild(displayTime[indexCount])
            indexCount++
        }
        
        scene.addChild(displayTimeContainer)
    }
    
    func set (time:(CGFloat, CGFloat)) {
        
        let itertime = stringsToList(String(time.0/100), m: String(time.1/100))
        var indexCount = 0
        
        displayTimeContainer.removeFromParent()
        
        for digit in itertime {
            
            displayTime[indexCount].removeFromParent()
            
            let digitSprite = SKSpriteNode(texture: SKTexture(rect: CGRect(x: Double(digit)!/10, y: 0.0, width: 0.1, height: 1.0), inTexture: spritesheetfull.texture!))
            
            digitSprite.position = CGPoint(x: xpos + CGFloat(digitWidth) * CGFloat(scalar) * CGFloat(indexCount), y: center.y)
            digitSprite.size = CGSize(width: digitSprite.size.width * CGFloat(scalar), height: digitSprite.size.height * CGFloat(scalar))
            digitSprite.anchorPoint = CGPoint(x: 0, y: 0)
            digitSprite.zPosition = 10
            
            displayTime[indexCount] = digitSprite
            displayTimeContainer.addChild(displayTime[indexCount])
            indexCount++
        }
        
        scene.addChild(displayTimeContainer)
        
    }
    
    
    func stringsToList (h: String, m: String) -> [String] {
        
        var itertime: [String] = []
        
        var currentHour = h
        var currentMin = m
        
        var index = currentHour.startIndex.advancedBy(2)
        
        index = currentHour.startIndex.advancedBy(2)
        currentHour = currentHour.substringFromIndex(index)
        if (currentHour.characters.count <= 1) {currentHour = "\(currentHour)\(0)"}
        for char in currentHour.characters {
            
            itertime.append(String(char))
        }
        
        index = currentMin.startIndex.advancedBy(2)
        currentMin = currentMin.substringFromIndex(index)
        if (currentMin.characters.count <= 1) {currentMin = "\(currentMin)\(0)"}
        for char in currentMin.characters {
            
            itertime.append(String(char))
        }
        
        
        for n in 0...itertime.count-1 {
            
            if (itertime[n] == ".") { itertime[n] = "0" }
            
        }
        
        return itertime
    }
    
    
    
    
    
}
