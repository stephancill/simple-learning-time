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
    
    var button1224HourToggle: SKSpriteNode = SKSpriteNode(texture: SKTexture(rect: CGRect(x: 0.0, y: 0.833, width: 0.166, height: 0.166), inTexture: SKTexture(imageNamed: "buttonAnimation1224HourToggle")))
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
        
        //Toggle 12/24 hour
        defaultButtonSetup(
            "button1224HourToggle",
            node: button1224HourToggle,
            position: CGPoint(
                x: frameSize.width/frameDivider*4,
                y: frameSize.height/frameDivider * (frameDivider-3)),
            frameSize: frameSize,
            scalar: scalar*2,
            frameDivider: frameDivider)
        
        //Random time
        defaultButtonSetup(
            "buttonRandomTime",
            node: buttonRandomTime,
            position: CGPoint(
                x: frameSize.width/frameDivider + (buttonRandomTime.size.width*CGFloat(scalar)/2),
                y: frameSize.height/frameDivider * (frameDivider-8)),
            frameSize: frameSize,
            scalar: scalar,
            frameDivider: frameDivider)
       
        //Current device time
        defaultButtonSetup(
            "buttonCurrentDeviceTime",
            node: buttonCurrentDeviceTime,
            position: CGPoint(
                x: frameSize.width/frameDivider*5+(buttonCurrentDeviceTime.size.width*CGFloat(scalar)/2),
                y: frameSize.height/frameDivider * (frameDivider-8)),
            frameSize: frameSize,
            scalar: scalar,
            frameDivider: frameDivider)
        
        //Toggle digital time
        defaultButtonSetup(
            "buttonToggleDigital",
            node: buttonToggleDigital,
            position: CGPoint(
                x: frameSize.width/frameDivider*0.7,
                y: dtm.center.y*2.35),
            frameSize: frameSize,
            scalar: scalar*0.4,
            frameDivider: frameDivider)
        
        scene.addChild(buttonContainer)
        
    }
    
    func buttonPressed (name: String) {
        
        touchedButtonName = name
        
    }
    
    func buttonReleased (name: String) {

        switch (name != touchedButtonName) {
        case(true): break
        case(false): ()
        }
        
        if (name == "button1224HourToggle") {
            toggleTwentyFourHour()
            print("button1224HourToggle")
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
        
        cm.twelveHour = !cm.twelveHour
        animate(
            button1224HourToggle,
            spritesheet: SKTexture(imageNamed: "buttonAnimation1224HourToggle"),
            frames: 36, fps: 16,
            size: CGSize(width: 0.166, height: 0.166),
            divisions: 6, framesPR: 6)
        
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
    
    func animate (sprite: SKSpriteNode, spritesheet: SKTexture, frames: Int, fps: Int, size: CGSize, divisions: Double=0, framesPR: Int=0) {
    
        for frameN in 0..<frames {
            print(frameN)
            var x = CGFloat((frameN%framesPR)/framesPR)
            var y = CGFloat(floor(Double(frameN)/Double(framesPR))/divisions)
            let texture: SKTexture = SKTexture(
                rect: CGRect(
                    x: x,
                    y: y,
                    width: 1/size.width, height: 1/size.height),
                inTexture: spritesheet)
            print("x:\(x), y: \(y)")
            sprite.texture = texture
            
        }
        
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