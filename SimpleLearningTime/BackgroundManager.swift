//
//  BackgroundManager.swift
//  SimpleLearningTime
//
//  Created by Stephan Cilliers on 2016/03/19.
//  Copyright © 2016 Stephan Cilliers. All rights reserved.
//

import Foundation
import SpriteKit

class BackgroundManager {

    var spriteMovingBackground = SKSpriteNode(imageNamed: "imageBackground")
    var spriteBackgroundColour = SKSpriteNode(color: UIColor(), size: UIScreen.mainScreen().bounds.size)
    
    func initElements (frameSize: CGSize, scalar:Float, scene:SKScene, center:CGPoint, time: (CGFloat, CGFloat)=(CGFloat(0), CGFloat(0))) {
        
        let mid = CGPoint(x: frameSize.width * 0.5, y: frameSize.height * 0.5)
        
        spriteMovingBackground.zPosition = -1
        spriteMovingBackground.anchorPoint = CGPoint(x:0.5, y:0.5)
        spriteMovingBackground.position = CGPoint(x:center.x, y: center.y/2)
        spriteMovingBackground.size = CGSize(width: spriteMovingBackground.size.width * CGFloat(scalar), height: spriteMovingBackground.size.height * CGFloat(scalar))
        scene.addChild(spriteMovingBackground)
        
        
        spriteBackgroundColour.position = mid
        spriteBackgroundColour.zPosition = -2
        scene.addChild(spriteBackgroundColour)
        
    }
    
    func set (time: (CGFloat, CGFloat)) {
    
        // Background's rotation is half of hour's rotation
        spriteMovingBackground.zRotation = cm.clockElements[cm.hourNodeID].zRotation/2
        
        // Background colour
        adjustBackgroundColor()
        
    }
    
    func rotate (delta: CGFloat) {
        
        spriteMovingBackground.zRotation += delta
        
    }
    
    func adjustBackgroundColor (hue: CGFloat=0.6, saturation: CGFloat=1, alpha: CGFloat=1){
        
        let brightness = abs((sqrt(pow(((cm.clockElements[cm.hourNodeID].zRotation / CGFloat(math.clockHourIntervalConst)) % cm.hourMod)-12,2))/12)%1-1)
        spriteBackgroundColour.color = UIColor(hue: hue-brightness/10, saturation: saturation, brightness: brightness, alpha: alpha)
        
    }
}