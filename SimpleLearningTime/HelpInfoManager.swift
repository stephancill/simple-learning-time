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
    
    var helpDescriptions = [String:SKSpriteNode]()
    
    init() {
        
        if (deviceType == "iPhone") {
            spriteHelp1224Hour = SKSpriteNode(imageNamed: "imageHelp1224HouriPhone")
            spriteHelpRandomTime = SKSpriteNode(imageNamed: "imageHelpRandomTimeiPhone")
            spriteHelpCurrentTime = SKSpriteNode(imageNamed: "imageHelpCurrentTimeiPhone")
            spriteHelpSelfTest = SKSpriteNode(imageNamed: "imageHelpSelfTestiPhone")
            spriteHelpDigitalToggle = SKSpriteNode(imageNamed: "imageHelpDigitalToggleiPhone")
            
            
        }
        
        helpDescriptions = [
            "button1224HourToggle" : spriteHelp1224Hour,
            "buttonRandomTime" : spriteHelpRandomTime,
            "buttonCurrentDeviceTime" : spriteHelpCurrentTime,
            "buttonSelfTest" : spriteHelpSelfTest,
            "buttonSelfTestEnd" : spriteHelpSelfTest,
            "buttonToggleDigital" : spriteHelpDigitalToggle,
//            "spriteHelpHour" : spriteHelpHour,
//            "spriteHelpMinute" : spriteHelpMinute
        ]

    }
    
    func initElements (scene: SKScene, visibility: Bool=false, scalar: Float=0.5) {
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
        
        btnm.defaultButtonSetup(
            "spriteHelpHour",
            node: spriteHelpHour,
            position: CGPoint(
                x: frameSize.width,
                y: frameSize.height),
            frameSize: frameSize,
            scalar: scalar,
            container: spriteContainer,
            zPosition: 5,
            anchorPoint: CGPoint(x: 1, y: 1)
        )
        
        btnm.defaultButtonSetup(
            "spriteHelpMinute",
            node: spriteHelpMinute,
            position: CGPoint(
                x: frameSize.width,
                y: frameSize.height),
            frameSize: frameSize,
            scalar: scalar,
            container: spriteContainer,
            zPosition: 5,
            anchorPoint: CGPoint(x: 1, y: 2)
        )
        
        if (deviceType == "iPhone") {
            /* Make case-specific adjustments here */
            
            
            let changeNodeList: [SKSpriteNode] = [
                spriteHelp1224Hour,
                spriteHelpRandomTime,
                spriteHelpCurrentTime,
                spriteHelpSelfTest,
                spriteHelpDigitalToggle,
            ]
            
            for node in changeNodeList {
                node.position.x = bgm.spriteUtilitiesBackground.size.width
                node.anchorPoint.x = 0
                node.removeFromParent()
            }
            
            spriteHelpMinute.removeFromParent()
            spriteHelpHour.removeFromParent()
            
        }
        
    }
    
    func animateHelpHelp () {
        
    }
    
    func show () {
        if (deviceType == "iPhone") {spriteContainer.addChild(spriteHelpMinute); spriteContainer.addChild(spriteHelpHour)}
        scene.addChild(spriteContainer)
        visible = true
    }
    
    func showNode (nodeName: String) {
        if (helpDescriptions.keys.contains(nodeName)) {
            spriteContainer.addChild(helpDescriptions[nodeName]!)
        }
        scene.addChild(spriteContainer)
        visible = true
    }
    
    func hide (force: Bool=false) {
        if (deviceType == "iPhone" && !btnm.forcePressed) { spriteContainer.removeAllChildren(); visible = false}
        if (!btnm.forcePressed) {spriteContainer.removeFromParent(); visible = false}
        if (force) { spriteContainer.removeAllChildren(); spriteContainer.removeFromParent(); visible = false }

    }
    
    func destroy () {
        spriteContainer.removeFromParent()
        spriteContainer.removeAllChildren()
    }
}
