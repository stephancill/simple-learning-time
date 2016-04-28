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
    
    var pressPressing: Bool = false
    var pressLongPressDuration: Double = 1
    var pressTimeOfPress: NSTimeInterval = NSTimeInterval()
    var longPressed: Bool = false
    
    // Button declarations
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
    
    
    var buttonShowHelp: SKSpriteNode =
        SKSpriteNode(
            texture: SKTexture(rect: CGRect(x: 0.0, y: 0.666, width: 0.1666, height: 0.333),
                inTexture: SKTexture(imageNamed: "animationShowHelp")
            )
    )
    
    // Misc declarations
    var propertySelfTestDefaultSize = true
    var propertySelfTestStartingSize = CGSize()
    var operationQueue = NSOperationQueue()
    var interactiveElements: [String] = [
        "button1224HourToggle",
        "buttonToggleDigital",
        "buttonCurrentDeviceTime",
        "buttonRandomTime",
        "buttonSelfTest",
        "buttonSelfTestEnd",
        "buttonShowHelp"
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
    
    func initElements (frameSize: CGSize, scalar: Float, scene: SKScene, frameDivider: CGFloat=100, inverseScalar: Float=1) {
        
        self.scene = scene
        
        stm.scene = scene
        
        
        
        //Toggle 12/24 hour
        defaultButtonSetup(
            "button1224HourToggle",
            node: button1224HourToggle,
            position: CGPoint(
                x: frameSize.width/frameDivider*11,
                y: frameSize.height/frameDivider * 90),
            frameSize: frameSize,
            scalar: scalar*1.76,
            frameDivider: frameDivider,
            container: buttonContainer
        )
        
        //Random time
        defaultButtonSetup(
            "buttonRandomTime",
            node: buttonRandomTime,
            position: CGPoint(
                x: frameSize.width/frameDivider * 4,
                y: frameSize.height/frameDivider * 75),
            frameSize: frameSize,
            scalar: scalar*0.93,
            frameDivider: frameDivider,
            container: buttonContainer
        )
       
        //Current device time
        defaultButtonSetup(
            "buttonCurrentDeviceTime",
            node: buttonCurrentDeviceTime,
            position: CGPoint(
                x: frameSize.width/frameDivider * 18,
                y: frameSize.height/frameDivider * 75),
            frameSize: frameSize,
            scalar: scalar*0.93,
            frameDivider: frameDivider,
            container: buttonContainer
        )
        
        //Toggle digital time
        defaultButtonSetup(
            "buttonToggleDigital",
            node: buttonToggleDigital,
            position: CGPoint(
                x: 0,
                y: dtm.center.y*2.35),
            frameSize: frameSize,
            scalar: scalar*0.9,
            frameDivider: frameDivider,
            container: buttonContainer,
            anchorPoint: CGPoint(x: 0, y: 0.5)
        )
        
        //Enter self-test mode
        defaultButtonSetup(
            "buttonSelfTest",
            node: buttonSelfTest,
            position: CGPoint(
                x: frameSize.width/frameDivider * 11,
                y: frameSize.height/frameDivider * 60),
            frameSize: frameSize,
            scalar: scalar*0.9,
            frameDivider: frameDivider,
            container: buttonContainer
        )
        propertySelfTestStartingSize = buttonSelfTest.size
        //Help button
        defaultButtonSetup(
            "buttonShowHelp",
            node: buttonShowHelp,
            position: CGPoint(
                x: frameSize.width/frameDivider * 95,
                y: frameSize.height/frameDivider * 5),
            frameSize: frameSize,
            scalar: scalar*0.9,
            frameDivider: frameDivider,
            container: buttonContainer
        )
        
        /*---*/
        defaultButtonSetup(
            "spriteSelfTestHelp2",
            node: stm.spriteSelfTestHelp2,
            position: CGPoint(
                x: buttonSelfTest.position.x ,
                y: buttonSelfTest.position.y),
            frameSize: frameSize,
            scalar: scalar*1.2,
            frameDivider: frameDivider,
            container: stm.spriteContainer,
            anchorPoint: CGPoint(x: 0.1, y: 1.27)
        )
        defaultButtonSetup(
            "spriteSelfTestHelp",
            node: stm.spriteSelfTestHelp,
            position: CGPoint(
                x: dtm.displayTime[4].position.x,
                y: dtm.displayTime[4].position.y),
            frameSize: frameSize,
            scalar: scalar*1.2,
            frameDivider: frameDivider,
            container: stm.spriteContainer,
            anchorPoint: CGPoint(x: 0.61, y: -1.5)
        )
        if (deviceType == "iPhone") {
            /* Make case-specific adjustments here */
            stm.spriteSelfTestHelp.position = CGPoint(
                x: bgm.spriteUtilitiesBackground.size.width ,
                y: dtm.displayTime[4].position.y)
            stm.spriteSelfTestHelp.anchorPoint = CGPoint(x: 0, y: -0.5)
            
            dc.classHimAdjust()
            
        }
        /*---*/
        
        scene.addChild(buttonContainer)
        
        print("btnm initialized")
    }
    
    func buttonPressed (name: String) {
        
        if (deviceType == "iPhone") { him.hide() }
        pressPressing = true
        pressTimeOfPress = NSDate.timeIntervalSinceReferenceDate()
        touchedButtonName = name
        print(touchedButtonName)
        
    }
    
    func buttonReleased (name: String) {
        
        pressPressing = false

        if (!longPressed) {
            switch (name != touchedButtonName) {
            case(true): break
            case(false): ()
            }
            
            if (name == "button1224HourToggle") {
                buttonFunctionToggleTwentyFourHour()
            }
            
            if (name == "buttonToggleDigital") {
                buttonFunctionToggleDigitalTime()
            }
            
            if (name == "buttonCurrentDeviceTime") {
                buttonFunctionCurrentTime()
                resetSTMResult()
            }
            
            if (name == "buttonRandomTime") {
                buttonFunctionRandomTime()
                resetSTMResult()
            }
            
            if (name == "buttonSelfTest" || name == "buttonSelfTestEnd") {
                if (operationQueue.operations.count == 0) {buttonFunctionSelfTest(name)}
            }
            
            if (name == "buttonShowHelp") {
                buttonFunctionShowHelp()
            }
        } else {
            him.hide()
        }
        longPressed = false

    }
    
    func update () {
        if (deviceType == "iPhone" && btnm.pressPressing) {
            let timeNow = NSDate.timeIntervalSinceReferenceDate()
            if ((timeNow - btnm.pressTimeOfPress)%3 >= btnm.pressLongPressDuration) {
                
                if (!him.visible) {
                    print("Longpressed")
                    longPressed = true
                    him.showNode(btnm.touchedButtonName)
                }
            }
        }
    }
    
    func buttonFunctionCurrentTime() {
        animateCurrentDeviceTime()
        
        cm.set(math.currentDeviceTime())
        dtm.set(cm.time)
    }
    
    func buttonFunctionRandomTime() {

        let hours = CGFloat(arc4random_uniform(24))
        let minutes = CGFloat(arc4random_uniform(59))
        animateRandomTime()
        
        cm.set(hours, minutes)
        dtm.set(cm.time)
    }
    
    func buttonFunctionToggleTwentyFourHour() {
        
        cm.twelveHour = !cm.twelveHour
        animate1224HourToggle(!cm.twelveHour)

        dtm.set(dtm.time)
    }
    
    func buttonFunctionToggleDigitalTime() {
        animateToggleDigital()
        dtm.toggleVisibility()
    }
    
    // Self testing feature procedures
    func buttonFunctionSelfTest (buttonName: String) {
        if (stm.testActive) {
            // Check solutions
            stm.check()
            if (stm.correct) {
                // Correct answer
                stm.endTest()
                animateSelfTestEnd(true, queue: true)
                animateSelfTestEnd(true, reverse: true, queue: true)
    
                switchSizes()
                
                operationQueue.addOperation(
                    ActionOperation(
                        node: buttonSelfTest,
                        action: SKAction.animateWithTextures(
                            [SKTexture(
                                rect: CGRect(x: 0.0, y: 0.75, width: 0.1428571429, height: 0.25),
                                inTexture: SKTexture(imageNamed: "animationSelfTestStart"))],
                            timePerFrame: Double(1)/Double(35)
                        )
                    )
                )
            } else {
                // Incorrect answer
                if (operationQueue.operations.count == 0) {
                    animateSelfTestEnd(false, queue: true)
                    animateSelfTestEnd(false, reverse: true, queue: true)
                }

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
        buttonSelfTest.size = propertySelfTestStartingSize
        propertySelfTestDefaultSize = true
        buttonSelfTest.texture = SKTexture(
            rect: CGRect(x: 0.0, y: 0.75, width: 0.1428571429, height: 0.25),
            inTexture: SKTexture(imageNamed: "animationSelfTestStart")
        )
    }
    
    func switchSizes() {
        if (!propertySelfTestDefaultSize) {
            operationQueue.addOperation(ActionOperation(node: buttonSelfTest, action: SKAction.scaleBy((1/0.6), duration: 0.1)))
            propertySelfTestDefaultSize = true
        } else {
            operationQueue.addOperation(ActionOperation(node: buttonSelfTest, action: SKAction.scaleBy(0.6, duration: 0.1)))
            propertySelfTestDefaultSize = false
        }
    }
    
    func buttonFunctionShowHelp () {
        animateShowHelp()
        if (!him.visible) {
            him.show()
        } else {
            him.hide()
        }
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
            if (propertySelfTestDefaultSize) {
                operationQueue.addOperation(ActionOperation(node: buttonSelfTest, action: SKAction.scaleBy(0.6, duration: 0.1)))
            }
            propertySelfTestDefaultSize = false
            // Replace with new animation from "checklist" to "–"
            buttonSelfTest.texture = SKTexture(
                rect: CGRect(x: 0.0, y: 0.5, width: 0.07142857143, height: 0.5),
                inTexture: SKTexture(imageNamed: "animationSelfTestEndCorrect")
            )
            
        } else {
            if (!propertySelfTestDefaultSize) {
                operationQueue.addOperation(ActionOperation(node: buttonSelfTest, action: SKAction.scaleBy((1/0.6), duration: 0.1)))
            }
            propertySelfTestDefaultSize = true
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
    
    func animateShowHelp (reverse: Bool=false) {
        animate(
            buttonShowHelp,
            spritesheet: SKTexture(imageNamed: "animationShowHelp"),
            frames: 18, fps: 35,
            size: CGSize(width: 0.16666666, height: 0.333),
            divisions: 3, framesPR: 6,
            reverse: reverse
        )
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
    
    func defaultButtonSetup(name: String, node: SKSpriteNode, position: CGPoint, frameSize: CGSize, scalar: Float=1,
                            frameDivider: CGFloat=100, container: SKNode, zPosition: CGFloat=10, anchorPoint: CGPoint=CGPoint(x: 0.5, y: 0.5)) {
        node.name = name
        node.zPosition = zPosition
        node.size = CGSize(
            width: node.size.width * CGFloat(scalar),
            height: node.size.height * CGFloat(scalar)
        )
        node.position = position
        node.anchorPoint = anchorPoint
        container.addChild(node)
    
    }
}