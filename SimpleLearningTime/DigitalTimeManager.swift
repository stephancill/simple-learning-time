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
    
    let digitHeight = 100.0
    let digitWidth = 56.0
    
    var xpos = 0.0
    
    func initElements (time:(CGFloat, CGFloat), mid:CGPoint, scalar:Float, scene:SKScene) {
        
        let itertime = stringsToList(String(time.0), m: String(time.1))
        print("Initialising dtm")
        
        var indexCount = 0
        for digit in itertime {
            
            xpos = Double(mid.x) - (2 * digitWidth * Double(scalar))
            //            let xpos = 0
            
            let digitSprite = SKSpriteNode(texture: SKTexture(rect: CGRect(x: Double(digit)!/10, y: 0.0, width: 0.1, height: 1.0), inTexture: spritesheetfull.texture!))
            
            digitSprite.position = CGPoint(x: xpos + Double(digitWidth) * Double(scalar) * Double(indexCount) , y: 0)
            digitSprite.size = CGSize(width: digitSprite.size.width * CGFloat(scalar), height: digitSprite.size.height * CGFloat(scalar))
            digitSprite.anchorPoint = CGPoint(x: 0, y: 0)
            
            displayTime.append(digitSprite)
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
            let digitSprite = SKSpriteNode(texture: SKTexture(rect: CGRect(x: Double(digit)!/10, y: 0.0, width: 0.1, height: 1.0), inTexture: spritesheetfull.texture!))
            
            digitSprite.position = CGPoint(x: xpos + Double(digitWidth) * Double(scalar) * Double(indexCount),y: 0)
            digitSprite.size = CGSize(width: digitSprite.size.width * CGFloat(scalar), height: digitSprite.size.height * CGFloat(scalar))
            digitSprite.anchorPoint = CGPoint(x: 0, y: 0)
            
            displayTime[indexCount] = digitSprite
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
            
            if (itertime[n] == ".") {
                
                itertime[n] = "0"
                
            }
            
        }
        
        return itertime
    }
    
    
    
    
    
}
