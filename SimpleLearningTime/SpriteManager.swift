//
//  SpriteManager.swift
//  SimpleLearningTime
//
//  Created by Stephan Cilliers on 2016/03/01.
//  Copyright © 2016 Stephan Cilliers. All rights reserved.
//

import SpriteKit

//var interactiveElements: [Int] = [1, 2]
var donotRender: [Int] = [2,3]
var interactiveElements: [Int] = [2,3]

class SpriteManager {
    
    
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
    
    func initElements (mid: CGPoint, scalar: Float, scene: GameScene, hourRot: Float?, minRot: Float?) -> Void{

        
        var layer = 0
        for element in clockElements {
            
            element.name = String(layer)
            element.position = mid
            element.size = CGSize(width: element.size.width * CGFloat(scalar), height: element.size.height * CGFloat(scalar))
            element.zPosition = CGFloat(layer)  // Order elements for visual consistency
            
            print(element.name)
            
            if (donotRender.contains(layer)){
                // Interactive
//                element.anchorPoint = CGPoint(x: 0.5,y: 0)
//                element.userInteractionEnabled = true
//                clockElements[layer - 3].addChild(element)
            } else {
//                element.anchorPoint = CGPoint(x: 0.5,y: 0.5)
                
                
            }
            scene.addChild(element)
            
            layer++
            
        }
        print("Setup: [2/2]Sprites initialised")
        
    
    }
    

    
}