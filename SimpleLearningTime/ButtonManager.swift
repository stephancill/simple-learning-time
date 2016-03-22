//
//  ButtonManager.swift
//  SimpleLearningTime
//
//  Created by Stephan Cilliers on 2016/03/18.
//  Copyright © 2016 Stephan Cilliers. All rights reserved.
//
import Foundation
import SpriteKit

class ButtonManager {
    
    var buttonHour12: SKSpriteNode = SKSpriteNode(imageNamed: "imageButton12hDisabled")
    var buttonHour24: SKSpriteNode = SKSpriteNode(imageNamed: "imageButton24hEnabled")
    var buttonToggleDigital: SKSpriteNode = SKSpriteNode(imageNamed: "imageButtonNoDigitalDisabled")
    
    var interactiveElements: [String] = ["buttonHour12", "buttonHour24", "buttonToggleDigital"]
    var buttonContainer: SKNode = SKNode()
    var scene: SKScene = SKScene()
    
    var touchedButtonName = ""
    
    init () {
        for name in interactiveElements {
            allInteractiveElements.append(name)
        }
    }
    
    func initElements (frameSize: CGSize, scalar: Double, scene: SKScene, frameDivider: CGFloat=35) {
        
        self.scene = scene
        
        /*Toggle 12/24 hour*/
        buttonHour12.name = "buttonHour12"
        buttonHour12.zPosition = 10
        buttonHour12.size = CGSize(
            width: buttonHour12.size.width * CGFloat(scalar),
            height: buttonHour12.size.height * CGFloat(scalar)
        )
        buttonHour12.position = CGPoint(
            x: frameSize.width/frameDivider+(buttonHour12.size.width/2),
            y: frameSize.height/frameDivider * (frameDivider-3)
        )
        
        
        buttonHour24.name = "buttonHour24"
        buttonHour24.zPosition = 10
        buttonHour24.size = CGSize(
            width: buttonHour24.size.width * CGFloat(scalar),
            height: buttonHour24.size.height * CGFloat(scalar)
        )
        buttonHour24.position = CGPoint(
            x: frameSize.width/frameDivider*4.7+(buttonHour12.size.width/2),
            y: frameSize.height/frameDivider * (frameDivider-3)
        )

        buttonContainer.addChild(buttonHour12)
        buttonContainer.addChild(buttonHour24)
        /*---*/
        
        /*Toggle digital time*/
        buttonToggleDigital.name = "buttonToggleDigital"
        buttonToggleDigital.zPosition = 10
        buttonToggleDigital.size = CGSize(
            width: buttonToggleDigital.size.width * CGFloat(scalar) ,
            height: buttonToggleDigital.size.height * CGFloat(scalar)
        )
        buttonToggleDigital.position = CGPoint(x: dtm.center.x, y: frameSize.height/frameDivider * (frameDivider-7))
        
        buttonContainer.addChild(buttonToggleDigital)
        /*---*/
        
        scene.addChild(buttonContainer)
        
    }
    
    func buttonPressed (name: String) {
        
        touchedButtonName = name
        
    }
    
    func buttonReleased (name: String) {

        switch (name != touchedButtonName) {
        case(true): break
        case(false): print("")
        }
        
        if (name == "buttonHour12" || name == "buttonHour24") {
            toggleTwentyFourHour()
            print("toggleTwentyFourHour")
        }
        
        if (name == "buttonToggleDigital") {
            toggleDigitalTime()
        }
    
    }
    
    func randomTime() {
    
        let hours = CGFloat(arc4random_uniform(24))
        let minutes = CGFloat(arc4random_uniform(13))
        
        cm.set(hours, minutes)
        dtm.set(cm.time)
    }
    
    func toggleTwentyFourHour() {
        
        if (!cm.twelveHour) {
            print("hi2")
            cm.twelveHour = true
            
            buttonHour12.texture = SKTexture(imageNamed: "imageButton12hEnabled")
            buttonHour24.texture = SKTexture(imageNamed: "imageButton24hDisabled")
        } else if (cm.twelveHour) {
            cm.twelveHour = false
            buttonHour12.texture = SKTexture(imageNamed: "imageButton12hDisabled")
            buttonHour24.texture = SKTexture(imageNamed: "imageButton24hEnabled")
        }
        
        cm.set(cm.calculateTime())
        dtm.set(cm.time)
    }
    
    func toggleDigitalTime() {
    
        if (dtm.enabled) {
            buttonToggleDigital.texture = SKTexture(imageNamed: "imageButtonNoDigitalDisabled")
        } else {
            buttonToggleDigital.texture = SKTexture(imageNamed: "imageButtonNoDigitalEnabled")
        }
        dtm.toggleVisibility()
    }
    
}