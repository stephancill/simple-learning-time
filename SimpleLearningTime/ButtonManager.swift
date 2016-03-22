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
    var buttonToggleDigital: SKSpriteNode = SKSpriteNode(imageNamed: "imageButtonNoDigitalEnabled")
    var buttonCurrentDeviceTime: SKSpriteNode = SKSpriteNode(imageNamed: "imageButtonCurrentTime")
    var buttonRandomTime: SKSpriteNode = SKSpriteNode(imageNamed: "imageButtonRandomAnalogue")
    
    var interactiveElements: [String] = [
        "buttonHour12",
        "buttonHour24",
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
        defaultButtonSetup(
            "buttonHour12",
            node: buttonHour12,
            position: CGPoint(
                x: frameSize.width/frameDivider + (buttonHour12.size.width*CGFloat(scalar)/2),
                y: frameSize.height/frameDivider * (frameDivider-3)),
            frameSize: frameSize,
            scalar: scalar,
            frameDivider: frameDivider)
        
        defaultButtonSetup(
            "buttonHour24",
            node: buttonHour24,
            position: CGPoint(
                x: frameSize.width/frameDivider*5+(buttonHour24.size.width*CGFloat(scalar)/2),
                y: frameSize.height/frameDivider * (frameDivider-3)),
            frameSize: frameSize,
            scalar: scalar,
            frameDivider: frameDivider)
        
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
                x: frameSize.width/frameDivider*7.5,
                y: frameSize.height/frameDivider*5.05) ,
            frameSize: frameSize,
            scalar: scalar*0.4,
            frameDivider: frameDivider)
        /*---*/
        
        scene.addChild(buttonContainer)
        
    }
    
    func buttonPressed (name: String) {
        
        touchedButtonName = name
        print(touchedButtonName)
        
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