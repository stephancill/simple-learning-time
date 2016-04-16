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
    
    var operationQueue = NSOperationQueue()
    
    
    var button1224HourToggle: SKSpriteNode =
        SKSpriteNode(
            texture: SKTexture(
                rect: CGRect(x: 0.0, y: 0.833, width: 0.166, height: 0.166),
                inTexture: SKTexture(imageNamed: "animation1224HourToggle")
            )
    )
    
    var buttonToggleDigital: SKSpriteNode =
        SKSpriteNode(
            imageNamed: "imageButtonNoDigitalEnabled"
    )
    
    var buttonCurrentDeviceTime: SKSpriteNode =
        SKSpriteNode(
            texture: SKTexture(
                rect: CGRect(x: 0.0, y: 0.75, width: 0.1428571429, height: 0.25),
                inTexture: SKTexture(imageNamed: "animationCurrentTimeNew")
            )
    )

    var buttonRandomTime: SKSpriteNode =
        SKSpriteNode(
            texture: SKTexture(rect: CGRect(x: 0.0, y: 0.75, width: 0.1428571429, height: 0.25),
                inTexture: SKTexture(imageNamed: "animationRandomAnalogueNew")
            )
    )
    
    var buttonSelfTest: SKSpriteNode =
        SKSpriteNode(
            texture: SKTexture(rect: CGRect(x: 0.0, y: 0.75, width: 0.1428571429, height: 0.25),
                inTexture: SKTexture(imageNamed: "animationSelfTestStart")
            )
    )
    
    var buttonSelfTestDefaultSize = true
//    var buttonSelfTest: SKSpriteNode =
//        SKSpriteNode(
//            texture: SKTexture(rect: CGRect(x: 0.0, y: 0.5, width: 0.07142857143, height: 0.5),
//                inTexture: SKTexture(imageNamed: "animationSelfTestEndCorrect")
//            )
//    )
    
    var interactiveElements: [String] = [
        "button1224HourToggle",
        "buttonToggleDigital",
        "buttonCurrentDeviceTime",
        "buttonRandomTime",
        "buttonSelfTest",
        "buttonSelfTestEnd"
    ]
    var buttonContainer: SKNode = SKNode()
    var scene: SKScene = SKScene()
    
    var touchedButtonName = ""
    
    init () {
        for name in interactiveElements {
            allInteractiveElements.append(name)
        }
        operationQueue.maxConcurrentOperationCount = 1; // disallow follow actions from overlapping one another
    }
    
    func initElements (frameSize: CGSize, scalar: Double, scene: SKScene, frameDivider: CGFloat=100) {
        self.scene = scene

        //Toggle 12/24 hour
        defaultButtonSetup(
            "button1224HourToggle",
            node: button1224HourToggle,
            position: CGPoint(
                x: frameSize.width/frameDivider*11,
                y: frameSize.height/frameDivider * 90),
            frameSize: frameSize,
            scalar: scalar*2,
            frameDivider: frameDivider)
        
        //Random time
        defaultButtonSetup(
            "buttonRandomTime",
            node: buttonRandomTime,
            position: CGPoint(
                x: frameSize.width/frameDivider * 4,
                y: frameSize.height/frameDivider * 80),
            frameSize: frameSize,
            scalar: scalar*0.93,
            frameDivider: frameDivider)
       
        //Current device time
        defaultButtonSetup(
            "buttonCurrentDeviceTime",
            node: buttonCurrentDeviceTime,
            position: CGPoint(
                x: frameSize.width/frameDivider * 18,
                y: frameSize.height/frameDivider * 80),
            frameSize: frameSize,
            scalar: scalar*0.93,
            frameDivider: frameDivider)
        
        //Toggle digital time
        buttonToggleDigital.anchorPoint = CGPoint(x: 0, y: 0.5)
        defaultButtonSetup(
            "buttonToggleDigital",
            node: buttonToggleDigital,
            position: CGPoint(
                x: 0,
                y: dtm.center.y*2.35),
            frameSize: frameSize,
            scalar: scalar*0.9,
            frameDivider: frameDivider)
        
        //Enter self-test mode
        defaultButtonSetup(
            "buttonSelfTest",
            node: buttonSelfTest,
            position: CGPoint(
                x: frameSize.width/frameDivider * 11,
                y: frameSize.height/frameDivider * 60),
            frameSize: frameSize,
            scalar: scalar*0.9,
            frameDivider: frameDivider)
        
        //Exit self-test mode
//        defaultButtonSetup(
//            "buttonSelfTestEnd",
//            node: buttonSelfTestEnd,
//            position: CGPoint(
//                x: frameSize.width/frameDivider * 18,
//                y: frameSize.height/frameDivider * 60),
//            frameSize: frameSize,
//            scalar: scalar*0.9,
//            frameDivider: frameDivider)
        
        scene.addChild(buttonContainer)
        
        print("btnm initialized")
    }
    
    func buttonPressed (name: String) {
        
        touchedButtonName = name
        print(touchedButtonName)
        
    }
    
    func buttonReleased (name: String) {

        switch (name != touchedButtonName) {
        case(true): break
        case(false): ()
        }
        
        if (name == "button1224HourToggle") {
            toggleTwentyFourHour()
        }
        
        if (name == "buttonToggleDigital") {
            toggleDigitalTime()
        }
        
        if (name == "buttonCurrentDeviceTime") {
            currentTime()
            resetSTMResult()
        }
        
        if (name == "buttonRandomTime") {
            randomTime()
            resetSTMResult()
        }
        
        if (name == "buttonSelfTest" || name == "buttonSelfTestEnd") {
            selfTest(name)
        }

    }
    
    func currentTime() {
        animateCurrentDeviceTime()
        
        cm.set(math.currentDeviceTime())
        dtm.set(cm.time)
    }
    
    func randomTime() {

        let hours = CGFloat(arc4random_uniform(24))
        let minutes = CGFloat(arc4random_uniform(13))
        animateRandomTime()
        
        cm.set(hours, minutes)
        dtm.set(cm.time)
    }
    
    func toggleTwentyFourHour() {
        
        cm.twelveHour = !cm.twelveHour
        animate1224HourToggle(!cm.twelveHour)

        dtm.set(dtm.time)
    }
    
    func toggleDigitalTime() {
        animateToggleDigital()
        dtm.toggleVisibility()
    }
    
    func selfTest (buttonName: String) {
        if (stm.testActive) {
            // Check solutions
            stm.check()
            if (stm.correct) {
                // Correct answer
                animateSelfTestEnd(stm.correct, queue: true)
                stm.endTest()
                animateSelfTestEnd(stm.correct, reverse: true, queue: true)
        
            } else {
                // Incorrect answer
                animateSelfTestEnd(stm.correct, queue: true)
                animateSelfTestEnd(stm.correct, reverse: true, queue: true)

            }
        } else {
            animateSelfTest()
            stm.startTest()
        }
    }
    
    func resetSTMResult () {
        if (stm.testActive) {
            stm.endTest()
        }
        buttonSelfTest.texture = SKTexture(
            rect: CGRect(x: 0.0, y: 0.75, width: 0.1428571429, height: 0.25),
            inTexture: SKTexture(imageNamed: "animationSelfTestStart")
        )
    }
    
    
    /* 
     Button animation configurations
    */
    
    func animate1224HourToggle (reverse: Bool=false) {
        animate(
            button1224HourToggle,
            spritesheet: SKTexture(imageNamed: "animation1224HourToggle"),
            frames: 36, fps: 100,
            size: CGSize(width: 0.166, height: 0.166),
            divisions: 6, framesPR: 6,
            reverse: reverse)
    }
    
    func animateToggleDigital (reverse: Bool=false) {
        if (dtm.enabled) {
            buttonToggleDigital.texture = SKTexture(imageNamed: "imageButtonNoDigitalDisabled")
        } else {
            buttonToggleDigital.texture = SKTexture(imageNamed: "imageButtonNoDigitalEnabled")
        }
    }
    
    func animateCurrentDeviceTime (reverse: Bool=false) {
        animate(
            buttonCurrentDeviceTime,
            spritesheet: SKTexture(imageNamed: "animationCurrentTimeNew"),
            frames: 27, fps: 35,
            size: CGSize(width: 0.1428571429, height: 0.25),
            divisions: 4, framesPR: 7,
            reverse: reverse)
    }
    
    func animateRandomTime (reverse: Bool=false) {
        animate(
            buttonRandomTime,
            spritesheet: SKTexture(imageNamed: "animationRandomAnalogueNew"),
            frames: 27, fps: 35,
            size: CGSize(width: 0.1428571429, height: 0.25),
            divisions: 4, framesPR: 7,
            reverse: reverse)
    }
    
    func animateSelfTest (reverse: Bool=false, queue: Bool=false) {
        if(!stm.testActive) {
            if (buttonSelfTestDefaultSize) {
                buttonSelfTest.size = CGSize(width: buttonSelfTest.size.width*0.6, height: buttonSelfTest.size.height*0.6)
            }
            buttonSelfTestDefaultSize = false
            // Replace with new animation from "checklist" to "–"
            buttonSelfTest.texture = SKTexture(
                rect: CGRect(x: 0.0, y: 0.5, width: 0.07142857143, height: 0.5),
                inTexture: SKTexture(imageNamed: "animationSelfTestEndCorrect")
            )
            
        } else {
            if (!buttonSelfTestDefaultSize) {
                buttonSelfTest.size = CGSize(width: buttonSelfTest.size.width*(1/0.6), height: buttonSelfTest.size.height*(1/0.6))
            }
            buttonSelfTestDefaultSize = true
            animate(
                buttonSelfTest,
                spritesheet: SKTexture(imageNamed: "animationSelfTestStart"),
                frames: 28, fps: 35,
                size: CGSize(width: 0.1428571429, height: 0.25),
                divisions: 4, framesPR: 7,
                reverse: reverse,
                queue: queue
            )
        }
        
    }
    
    func animateSelfTestEnd (correct: Bool, reverse: Bool=false, queue: Bool=false) {
        
        if (correct) {
            animate(
                buttonSelfTest,
                spritesheet: SKTexture(imageNamed: "animationSelfTestEndCorrect"),
                frames: 28, fps: 35,
                size: CGSize(width: 0.07142857143, height: 0.5),
                divisions: 2, framesPR: 14,
                reverse: reverse,
                queue: queue
            )
        } else {
            animate(
                buttonSelfTest,
                spritesheet: SKTexture(imageNamed: "animationSelfTestEndIncorrect"),
                frames: 28, fps: 35,
                size: CGSize(width: 0.07142857143, height: 0.5),
                divisions: 2, framesPR: 14,
                reverse: reverse,
                queue: queue
            )
        }
    }
    
    func animate (sprite: SKSpriteNode, spritesheet: SKTexture, frames: Int, fps: Int, size: CGSize, divisions: Double=1, framesPR: Int=1, reverse: Bool=false, queue: Bool=false) {
        
        var textures: [SKTexture] = []
        for frameN in 0..<frames {
            
            let ydiv = 1-(1/divisions)
            let x = CGFloat(Double(frameN % framesPR) / Double(framesPR))
            let y = CGFloat(ydiv - floor(Double(frameN) / Double(framesPR)) / divisions)
            let texture: SKTexture = SKTexture(
                rect: CGRect(
                    x: x,
                    y: y,
                    width: size.width, height: size.height),
                inTexture: spritesheet)
            textures.append(texture)
            
        }
        
        if (reverse) { textures = textures.reverse() }
        
        let action = SKAction.animateWithTextures(textures, timePerFrame: Double(1)/Double(fps))
        
        if (queue) {
            operationQueue.addOperation(ActionOperation(node: sprite, action: action))
        } else {
            sprite.runAction(action)
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