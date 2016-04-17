//
//  HelpInfoManager.swift
//  SimpleLearningTime
//
//  Created by Stephan Cilliers on 2016/04/17.
//  Copyright © 2016 Stephan Cilliers. All rights reserved.
//

import SpriteKit

class HelpInfoManager {
    
    var spriteHelp1224Hour: SKSpriteNode = SKSpriteNode(imageNamed: "imageHelp1224Hour")
    var spriteHelpRandomTime: SKSpriteNode = SKSpriteNode(imageNamed: "imageHelpRandomTime")
    var spriteHelpCurrentTime: SKSpriteNode = SKSpriteNode(imageNamed: "imageHelpCurrentTime")
    var spriteHelpSelfTest: SKSpriteNode = SKSpriteNode(imageNamed: "imageHelpSelfTest")
    var spriteHelpDigitalToggle: SKSpriteNode = SKSpriteNode(imageNamed: "imageHelpDigitalToggle")
    var spriteHelpHour: SKSpriteNode = SKSpriteNode(imageNamed: "imageHelpHour")
    var spriteHelpMinute: SKSpriteNode = SKSpriteNode(imageNamed: "imageHelpMinute")
    
    var spriteContainer: SKNode = SKNode()
    
    var visible: Bool = false
    var scene: SKScene = SKScene()
    
    func instantiate (scene: SKScene, visibility: Bool=false, scalar: Double=0.5) {
        self.scene = scene
        let frameSize = scene.size
        visible = visibility
        
        btnm.defaultButtonSetup(
            "spriteHelp1224Hour",
            node: spriteHelp1224Hour,
            position: CGPoint(
                x: btnm.button1224HourToggle.position.x,
                y: frameSize.height - btnm.button1224HourToggle.position.y),
            frameSize: frameSize,
            scalar: scalar,
            container: spriteContainer,
            zPosition: 5,
            anchorPoint: CGPoint(x: -0.06, y: 1.5)
        )
        
        btnm.defaultButtonSetup(
            "spriteHelpRandomTime",
            node: spriteHelpRandomTime,
            position: CGPoint(
                x: btnm.buttonRandomTime.position.x,
                y: btnm.buttonRandomTime.position.y),
            frameSize: frameSize,
            scalar: scalar,
            container: spriteContainer,
            zPosition: 5,
            anchorPoint: CGPoint(x: -0.08, y: -1.79)
        )
//        
        btnm.defaultButtonSetup(
            "spriteHelpCurrentTime",
            node: spriteHelpCurrentTime,
            position: CGPoint(
                x: btnm.buttonCurrentDeviceTime.position.x,
                y: btnm.buttonCurrentDeviceTime.position.y),
            frameSize: frameSize,
            scalar: scalar,
            container: spriteContainer,
            zPosition: 5,
            anchorPoint: CGPoint(x: -0.54, y: -4.27)
        )
//
        btnm.defaultButtonSetup(
            "spriteHelpSelfTest",
            node: spriteHelpSelfTest,
            position: CGPoint(
                x: btnm.buttonSelfTest.position.x,
                y: btnm.buttonSelfTest.position.y),
            frameSize: frameSize,
            scalar: scalar,
            container: spriteContainer,
            zPosition: 5,
            anchorPoint: CGPoint(x: -0.21, y: -0.6)
        )
//
        btnm.defaultButtonSetup(
            "spriteHelpDigitalToggle",
            node: spriteHelpDigitalToggle,
            position: CGPoint(
                x: btnm.buttonToggleDigital.position.x,
                y: btnm.buttonToggleDigital.position.y),
            frameSize: frameSize,
            scalar: scalar,
            container: spriteContainer,
            zPosition: 5,
            anchorPoint: CGPoint(x: -0.005, y: -0.42)
        )
        
        
        // Add all sprites to scene
        
    }
    
    func show () {
        scene.addChild(spriteContainer)
        visible = true
    }
    
    func hide () {
        spriteContainer.removeFromParent()
        visible = false
    }
    
    func destroy () {
        spriteContainer.removeFromParent()
        spriteContainer.removeAllChildren()
    }
}
