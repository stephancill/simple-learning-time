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
    
    
    override func didMoveToView(view: SKView) {
        
        /* Setup your scene here */
        self.name = "scene"
        middle = CGPoint(x: size.width * 0.5, y: size.height * 0.5)
        
        /*---*/
        tmpSpriteBackground.position = middle
        tmpSpriteBackground.zPosition = -2
        self.addChild(tmpSpriteBackground)
//        tmpSpriteBackground.color = UIColor.
        /*---*/
        
        cm.initElements(size, scalar: 0.55, scene: self, time: math.currentDeviceTime())
        dtm.initElements(size, time: cm.time, scalar: 0.5, scene: self)
        
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        cm.touchesMoved(touches)
    
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        cm.touchesBegan(touches, scene: self)
        
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        cm.touchesEnded(touches)
    
    }
    

}
