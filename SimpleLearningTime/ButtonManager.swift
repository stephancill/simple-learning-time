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
    
    var button1224HourToggle: SKSpriteNode = SKSpriteNode(texture: SKTexture(rect: CGRect(x: 0.0, y: 0.8571428571, width: 0.166, height: 0.1428571429), inTexture: SKTexture(imageNamed: "buttonAnimation1224HourToggle")))
    var buttonToggleDigital: SKSpriteNode = SKSpriteNode(imageNamed: "imageButtonNoDigitalEnabled")
    var buttonCurrentDeviceTime: SKSpriteNode = SKSpriteNode(imageNamed: "imageButtonCurrentTime")
    var buttonRandomTime: SKSpriteNode = SKSpriteNode(imageNamed: "imageButtonRandomAnalogue")
    
    var interactiveElements: [String] = [
        "button1224HourToggle",
        "buttonToggleDigital",
        "buttonCurrentDeviceTime",
        "buttonRandomTime"]
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
//        defaultButtonSetup(
//            "button1224HourToggle",
//            node: button1224HourToggle,
//            position: CGPoint(
//                x: frameSize.width/frameDivider + (button1224HourToggle.size.width*CGFloat(scalar)/2),
//                y: frameSize.height/frameDivider * (frameDivider-3)),
//            frameSize: frameSize,
//            scalar: scalar,
//            frameDivider: frameDivider)
        
//        button1224HourToggle.name = "button1224HourToggle"
//        button1224HourToggle.zPosition = 10
//        button1224HourToggle.size = CGSize(
//            width: 450,
//            height: 150
//        )
//        button1224HourToggle.position = CGPoint(x: 100, y: 100)
//        buttonContainer.addChild(button1224HourToggle)
        defaultButtonSetup(
            "button1224HourToggle",
            node: button1224HourToggle,
            position: CGPoint(
                x: frameSize.width/frameDivider*4,
                y: frameSize.height/frameDivider * (frameDivider-3)),
            frameSize: frameSize,
            scalar: scalar*2,
            frameDivider: frameDivider)
        
//        defaultButtonSetup(
//            "buttonHour24",
//            node: button1224HourToggle,
//            position: CGPoint(
//                x: frameSize.width/frameDivider*5+(button1224HourToggle.size.width*CGFloat(scalar)/2),
//                y: frameSize.height/frameDivider * (frameDivider-3)),
//            frameSize: frameSize,
//            scalar: scalar,
//            frameDivider: frameDivider)
        
        /*---*/
        
        
        /*Random time*/
        defaultButtonSetup(
            "buttonRandomTime",
            node: buttonRandomTime,
            position: CGPoint(
                x: frameSize.width/frameDivider + (buttonRandomTime.size.width*CGFloat(scalar)/2),
                y: frameSize.height/frameDivider * (frameDivider-8)),
            frameSize: frameSize,
            scalar: scalar,
            frameDivider: frameDivider)
        /*---*/
       
        /*Current device time*/
        defaultButtonSetup(
            "buttonCurrentDeviceTime",
            node: buttonCurrentDeviceTime,
            position: CGPoint(
                x: frameSize.width/frameDivider*5+(buttonCurrentDeviceTime.size.width*CGFloat(scalar)/2),
                y: frameSize.height/frameDivider * (frameDivider-8)),
            frameSize: frameSize,
            scalar: scalar,
            frameDivider: frameDivider)
        /*---*/
        
        /*Toggle digital time*/
        defaultButtonSetup(
            "buttonToggleDigital",
            node: buttonToggleDigital,
            position: CGPoint(
                x: frameSize.width/frameDivider*0.7,
                y: dtm.center.y*2.35),
            frameSize: frameSize,
            scalar: scalar*0.4,
            frameDivider: frameDivider)
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
        
        if (name == "buttonAnimation1224HourToggle") {
            toggleTwentyFourHour()
        }
        
        if (name == "buttonToggleDigital") {
            toggleDigitalTime()
        }
        
        if (name == "buttonCurrentDeviceTime") {
            currentTime()
        }
        
        if (name == "buttonRandomTime") {
            randomTime()
        }

    }
    
    func currentTime() {
        print("currenttime")
        cm.set(math.currentDeviceTime())
        dtm.set(cm.time)
    }
    
    func randomTime() {
    
        let hours = CGFloat(arc4random_uniform(24))
        let minutes = CGFloat(arc4random_uniform(13))
        
        cm.set(hours, minutes)
        dtm.set(cm.time)
    }
    
    func toggleTwentyFourHour() {
        
        if (!cm.twelveHour) {
            cm.twelveHour = true
            
            button1224HourToggle.texture = SKTexture(imageNamed: "imageButton12hEnabled")
            button1224HourToggle.texture = SKTexture(imageNamed: "imageButton24hDisabled")
        } else if (cm.twelveHour) {
            cm.twelveHour = false
            button1224HourToggle.texture = SKTexture(imageNamed: "imageButton12hDisabled")
            button1224HourToggle.texture = SKTexture(imageNamed: "imageButton24hEnabled")
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
    
    func animate (sprite: SKSpriteNode, spritesheet: SKTexture, frames: Int, fps: Int, size: CGSize, divisions: Int=0, framesPR: Int=0) {
    
//        var index = 0
//        for frameN in 0..<frames {
//        
//            var texture: SKTexture = SKTexture(
//                rect: CGRect(
//                    x: 0, y: 0,
//                    width: size.width, height: size.height),
//                inTexture: <#T##SKTexture#>)
//            
//            
//        }
        
    }
    
    func defaultButtonSetup(name: String, node: SKSpriteNode, position: CGPoint, frameSize: CGSize, scalar: Double=1,
        
        frameDivider: CGFloat=35) {
        node.name = name
        node.zPosition = 10
        node.size = CGSize(
            width: node.size.width * CGFloat(scalar),
            height: node.size.height * CGFloat(scalar)
        )
        node.position = position
        buttonContainer.addChild(node)
    
    }
}