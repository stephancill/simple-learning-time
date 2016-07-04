//
//  GameScene.swift
//  SimpleLearningTime
//
//  Created by Stephan Cilliers on 2016/02/11.
//  Copyright (c) 2016 Stephan Cilliers. All rights reserved.
//
import SpriteKit

let cm: ClockManager = ClockManager()
let bgm: BackgroundManager = BackgroundManager()
let dtm: DigitalTimeManager = DigitalTimeManager()
let btnm: ButtonManager = ButtonManager()
let stm: SelfTestManager = SelfTestManager()
let him: HelpInfoManager = HelpInfoManager()
let dc: DeviceConfigurations = DeviceConfigurations()
let math: mf = mf()

var allInteractiveElements: [String] = []

class CustomGameScene: SKScene {

    var middle: CGPoint = CGPoint(x: 0, y: 0)
    var inverseScalar: Float = 1 /* iPhone = 3.23529, iPad = 1*/
    
    var lastTouch: UITouch = UITouch()
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        self.name = "scene"
        middle = CGPoint(x: size.width * 0.5, y: size.height * 0.5)
        
        if (deviceType == "iPhone") {
            cm.initElements(size, scalar: 0.55/inverseScalar*0.85, scene: self, time: math.currentDeviceTime())
        } else {
            cm.initElements(size, scalar: 0.55/inverseScalar, scene: self, time: math.currentDeviceTime())
        }
        bgm.initElements(size, scalar: 0.8/inverseScalar, scene: self, center: cm.center)
        dtm.initElements(size, scalar: 0.6/inverseScalar, scene: self, time: cm.time)
        him.initElements(self, scalar: 0.5/inverseScalar)
        btnm.initElements(size, scalar: 0.3/inverseScalar, scene: self, inverseScalar: inverseScalar)
	
		
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let touchLocation = convertPointFromView((touches.first?.locationInView(self.view))!)
        cm.touchesMoved(touchLocation)
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
    
        let node = getTopNode(touches)
        let nodeName = node.name!
        lastTouch = touches.first!
        
        if (cm.interactiveElements.contains(nodeName)) {
            // Element belongs to clock
            print ("cm")
            cm.touchesStarted(node, touchLocation: convertPointFromView((touches.first?.locationInView(self.view))!))
        } else if (btnm.interactiveElements.contains(nodeName)) {
            // Element belongs to clock class
            print ("btnm")
            btnm.buttonPressed(nodeName, touch: touches.first!)
        } else {
            print ("else \(him.visible)")
            if (him.visible) {him.hide()}
        }

    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        let node = getTopNode(touches)
        let nodeName = node.name!

        // Element belongs to clock
        if (cm.interactivityEnabled) {
            cm.touchesEnded()
        }
        
        btnm.buttonReleased(nodeName)

    }
    
    override func update(currentTime: NSTimeInterval) {
        
        btnm.update(lastTouch)
    }
    
    func getTopNode (touches: Set<UITouch>) -> SKNode {
        
        let touch = touches.first
        let touchLocation = touch!.locationInView(self.view)
        var node: SKNode = SKNode()
        let nodes = self.nodesAtPoint(convertPointFromView(touchLocation))
        //  Set the node to the first interactive node
        for n in nodes {
            if (n.name != nil) {
                if (allInteractiveElements.contains(n.name!)) {
                    node = n
                    break
                }
            }
        }
        
        if (node.name == nil) {node.name = "nil"}
        return node
        
    }
	
	func setTime(time: (CGFloat, CGFloat)) {
		cm.set(time)
		dtm.set(time)
	}

}
