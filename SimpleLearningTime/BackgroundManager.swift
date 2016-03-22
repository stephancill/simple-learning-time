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
    var spriteBackgroundHill = SKSpriteNode(imageNamed: "imageBackgroundHill")
    var spriteUtilitiesBackground = SKSpriteNode()
    var spriteBackgroundColor = SKSpriteNode(color: UIColor(), size: UIScreen.mainScreen().bounds.size)
    
    func initElements (frameSize: CGSize, scalar:Float, scene:SKScene, center:CGPoint, time: (CGFloat, CGFloat)=(CGFloat(0), CGFloat(0)), frameDivider:CGFloat=35) {
        
        let mid = CGPoint(x: frameSize.width * 0.5, y: frameSize.height * 0.5)
        
        spriteUtilitiesBackground.name = "spriteUtilitiesBackground"
        spriteUtilitiesBackground = SKSpriteNode(color: UIColor(white: 1, alpha: 0.2), size: CGSize(width: frameSize.width/frameDivider*4*4, height: frameSize.height*2))
        spriteUtilitiesBackground.zPosition = -1
        scene.addChild(spriteUtilitiesBackground)
        
        spriteBackgroundHill.name = "spriteBackgroundHill"
        spriteBackgroundHill.zPosition = -2
        spriteBackgroundHill.anchorPoint = CGPoint(x: 0.5, y: 0.0)
        spriteBackgroundHill.position = CGPoint(x:frameSize.width/2, y: 0)
        spriteBackgroundHill.size = (CGSize(width: frameSize.width, height: frameSize.height))
        scene.addChild(spriteBackgroundHill)
        
        spriteMovingBackground.name = "spriteMovingBackground"
        spriteMovingBackground.zPosition = -3
        spriteMovingBackground.anchorPoint = CGPoint(x:0.5, y:0.5)
        spriteMovingBackground.position = CGPoint(x:center.x, y: center.y/2)
        spriteMovingBackground.size = CGSize(width: spriteMovingBackground.size.width * CGFloat(scalar), height: spriteMovingBackground.size.height * CGFloat(scalar))
        scene.addChild(spriteMovingBackground)
        
        spriteBackgroundColor.name = "spriteBackgroundColor"
        spriteBackgroundColor.zPosition = -4
        spriteBackgroundColor.position = mid
        scene.addChild(spriteBackgroundColor)
        
    }
    
    func set (time: (CGFloat, CGFloat)) {
    
        // Background's rotation is half of hour's rotation
        spriteMovingBackground.zRotation = cm.spriteClockHour.zRotation/2
        
        // Background Color
        adjustBackgroundColor()

    }
    
    func rotate (delta: CGFloat) {
        
        spriteMovingBackground.zRotation += delta
        
    }
    
    func adjustBackgroundColor (hue: CGFloat=0.62, saturation: CGFloat=1, alpha: CGFloat=1){
        
        var brightness = abs((sqrt(pow(abs((cm.spriteClockHour.zRotation / CGFloat(math.clockHourIntervalConst)) % cm.hourMod)-12,2))/12)%1-1)
        
        if (cm.spriteClockHour.zRotation / CGFloat(math.clockHourIntervalConst) % 24 == 0) {brightness = 0.00001}
        
        spriteBackgroundColor.color = UIColor(hue: hue-brightness/10, saturation: saturation, brightness: brightness, alpha: alpha)
        
        spriteBackgroundHill.color = spriteBackgroundColor.color
        spriteBackgroundHill.colorBlendFactor = 0.9
    }
}