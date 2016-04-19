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
var him: HelpInfoManager = HelpInfoManager()
let math: mf = mf()

var allInteractiveElements: [String] = []

class CustomGameScene: SKScene {

    var middle: CGPoint = CGPoint(x: 0, y: 0)
    var inverseScalar: Float = 1 /* iPhone = 3.23529, iPad = 1*/
    
    override func didMoveToView(view: SKView) {
        
        /* Setup your scene here */
        self.name = "scene"
        middle = CGPoint(x: size.width * 0.5, y: size.height * 0.5)
        
        cm.initElements(size, scalar: 0.55/inverseScalar, scene: self, time: math.currentDeviceTime())
        bgm.initElements(size, scalar: 0.8/inverseScalar, scene: self, center: cm.center)
        dtm.initElements(size, scalar: 0.6/inverseScalar, scene: self, time: cm.time)
        btnm.initElements(size, scalar: 0.25/inverseScalar, scene: self, inverseScalar: inverseScalar)
        // him instantiated in btnm
        
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let touchLocation = convertPointFromView((touches.first?.locationInView(self.view))!)
        cm.touchesMoved(touchLocation)
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        let node = getTopNode(touches)
        let nodeName = node.name!
        
        if (cm.interactiveElements.contains(nodeName)) {
            cm.touchesStarted(node, touchLocation: convertPointFromView((touches.first?.locationInView(self.view))!))
        } else if (btnm.interactiveElements.contains(nodeName)) {
            btnm.buttonPressed(nodeName)
        } else {
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
    
    func pointConverter (point: CGPoint) {
        convertPointFromView(point)
    }
    

}
