//
//  GameScene.swift
//  SimpleLearningTime
//
//  Created by Stephan Cilliers on 2016/02/11.
//  Copyright (c) 2016 Stephan Cilliers. All rights reserved.
//
import SpriteKit

let cm: ClockManager = ClockManager()
let bgm: BackgroundManager = BackgroundManager()
let dtm: DigitalTimeManager = DigitalTimeManager()
let math: mf = mf()

class GameScene: SKScene {
    
    
    
    var middle: CGPoint = CGPoint(x: 0, y: 0)
    
    
    override func didMoveToView(view: SKView) {
        
        /* Setup your scene here */
        self.name = "scene"
        middle = CGPoint(x: size.width * 0.5, y: size.height * 0.5)
        
        cm.initElements(size, scalar: 0.55, scene: self, time: math.currentDeviceTime())
        bgm.initElements(size, scalar: 0.8, scene: self, center: cm.center)
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
